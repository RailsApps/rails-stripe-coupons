class MailingListSignupJob < ApplicationJob

  def perform(user)
    MailingListSignupService.new.perform(user)
  end

end
