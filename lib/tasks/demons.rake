require 'qu/tasks'
namespace :railsbike do
  namespace :demons do
    namespace :qu do
      %w{start stop restart status}.each do |action|

        desc "Qu server demon #{action}"
        task action.to_sym => [:environment] do
          #Rake::Task['qu:work'].invoke
          p "Invokes #{action} actions"
        end

      end
    end
    
  end
end