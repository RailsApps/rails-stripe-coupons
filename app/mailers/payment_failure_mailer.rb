class PaymentFailureMailer < ApplicationMailer
  default from: "do-not-reply@example.com",
            cc: Rails.application.secrets.admin_email

  def failed_payment_email(user)
    @user = user
    mail(to: user.email, :subject => "Payment Failed")
  end
end
