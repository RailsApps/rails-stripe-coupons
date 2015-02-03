class MakePaymentService

  def perform(user)
    if !user.stripe_token.present?
      user.errors[:base] << 'Could not verify card.'
      raise ActiveRecord::RecordInvalid.new(user)
    end
    customer = create_customer(user)
    charge = create_charge(customer)
    user.stripe_token = nil
    Rails.logger.info("Stripe transaction for #{user.email}") if charge[:paid] == true
  rescue Stripe::InvalidRequestError => e
    user.errors[:base] << e.message
    user.stripe_token = nil
    raise ActiveRecord::RecordInvalid.new(user)
  rescue Stripe::CardError => e
    user.errors[:base] << e.message
    user.stripe_token = nil
    raise ActiveRecord::RecordInvalid.new(user)
  end

  def create_customer(user)
    customer = Stripe::Customer.create(
      :email => user.email,
      :card => user.stripe_token
    )
  end

  def create_charge(customer)
    price = Rails.application.secrets.product_price
    title = Rails.application.secrets.product_title
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => "#{price}",
      :description => "#{title}",
      :currency    => 'usd'
    )
  end

end