class PaymentJob < ActiveJob::Base

  def perform(user)
    user.make_payment
  end

end