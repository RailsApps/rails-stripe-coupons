class MailingListSignupService

  def perform(user)
    mailchimp = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
    list_id = Rails.application.secrets.mailchimp_list_id
    result = mailchimp.lists(list_id).members.create(
      body: {
        email_address: user.email,
        status: 'subscribed'
    })
    Rails.logger.info("Subscribed #{user.email} to MailChimp") if result
  end

end
