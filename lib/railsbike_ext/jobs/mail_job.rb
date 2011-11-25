module RailsbikeExt
  module Jobs
    class MailJob
      def self.perform(args)
        begin
          account = Account.where(:email => args[:email]).first
          p args
          content = ContentType.where(:slug => args[:content_type]).first.contents.find(args[:content_id])
          Admin::Notifications.new_content_instance(account, content).deliver
        rescue Exception => e
          p e
        end
      end
    end
  end
end