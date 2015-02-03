class MakePaymentService

  def perform(user)
    if !user.stripe_token.present?
      user.errors[:base] << 'Could not verify card.'
      raise ActiveRecord::RecordInvalid.new(user)
    end
    customer = create_customer(user)
    charge = create_charge(customer, user)
    user.stripe_token = nil
    Rails.logger.info("Stripe transaction for #{user.email}") if charge[:paid] == true
  rescue Stripe::InvalidRequestError => e
    user.errors[:base] << e.message
    PaymentFailureMailer.failed_payment_email(user).deliver_now
    user.destroy
  rescue Stripe::CardError => e
    user.errors[:base] << e.message
    PaymentFailureMailer.failed_payment_email(user).deliver_now
    user.destroy
  end

  def create_customer(user)
    customer = Stripe::Customer.create(
      :email => user.email,
      :card => user.stripe_token
    )
  end

  def create_charge(customer, user)
    price = user.coupon.nil? ?
      Rails.application.secrets.product_price : user.coupon.price
    title = Rails.application.secrets.product_title
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => "#{price}",
      :description => "#{title}",
      :currency    => 'usd'
    )
  end

end
