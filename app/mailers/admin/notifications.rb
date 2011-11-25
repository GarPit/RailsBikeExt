module Admin
  class Notifications < ActionMailer::Base

    default :from => Locomotive.config.mailer_sender

    def new_content_instance(account, content)
      @account, @content = account, content
      #fetch mailer for content_type
      @mailer = @content.content_type.liquid_mailer
      @options = {}
      if @mailer
        @options["content"] = @content
        @options["sent_on"] = Time.now
        @options["content_type"] = @content.content_type.name
        subject = @mailer.subject
      else
        subject = t('admin.notifications.new_content_instance.subject', :type => @content.content_type.name, :locale => @account.locale)
      end
      
      mail :subject => subject, :to => @account.email 
    end
  end

end