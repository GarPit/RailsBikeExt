module RailsbikeExt
  class QuDaemon < ::DaemonSpawn::Base
    
    def start(args)
      queues = (ENV['QUEUES'] || ENV['QUEUE'] || 'default').to_s.split(',')
      Qu::Worker.new(*queues).start
    end
    
    def stop
      
    end
  end
  
  
end