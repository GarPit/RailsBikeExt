require 'qu/tasks'
namespace :railsbike do
  namespace :demons do
    namespace :qu do
      %w{start stop restart status}.each do |action|

        desc "Qu server demon #{action}"
        task action.to_sym => [:environment] do
          RailsbikeExt::QuDaemon.spawn!(
          {
            :log_file => '/tmp/qu_server.log',
            :pid_file => '/tmp/qu_server.pid',
            :sync_log => true,
            :working_dir => "/tmp"
          },
          [action]
          )
        end

      end
    end
    
  end
end