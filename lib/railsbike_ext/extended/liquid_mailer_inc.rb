module RailsbikeExt
  module LiquidMailerInc
    module LiquidMailerIncSite
      extend ActiveSupport::Concern
      included do
        references_many :liquid_mailers 
      end
    end
    
    Site.send :include, LiquidMailerIncSite
    
    module LiquidMailerIncModel
      extend ActiveSupport::Concern
      included do
         referenced_in :liquid_mailer
      end
      
      module ClassMethods
        def free
          all.select{|i| i.liquid_mailers.blank?}
        end
      end
    end
    
    ContentType.send :include, LiquidMailerIncModel
  end
end