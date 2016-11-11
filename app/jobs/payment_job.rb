class PaymentJob < ApplicationJob

  def perform(user)
    MakePaymentService.new.perform(user)
  end

end
