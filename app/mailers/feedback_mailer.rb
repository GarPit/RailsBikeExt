class FeedbackMailer < ActionMailer::Base
  #
  # Delivers an email template to one or more receivers
  # options - Hash with keys:
  #  :subject - Feedback subject
  #  :from - Feedback from (default - postmaster@sitename.org)
  #  :model - object to parse
  #
  def email_template(to, email_template, options = {})
    subject options[:subject]
    recipients to
    from options[:from]
    sent_on Time.now
    cc options[:cc] if options.key?(:cc)
    bcc options[:bcc] if options.key?(:bcc)
    body :body => Liquid::Template.parse(email_template).render(options) if email_template
  end
end