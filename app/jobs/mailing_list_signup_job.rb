class MailingListSignupJob < ActiveJob::Base

  def perform(user)
    MailingListSignupService.new.perform(user)
  end

end
