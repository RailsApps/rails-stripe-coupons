class PaymentJob < ActiveJob::Base

  def perform(user)
    MakePaymentService.new.perform(user)
  end

end
