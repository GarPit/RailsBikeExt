puts ".. loading Railsbike-LiquidMailer engine"
module Railsbike
  module Core
    module LiquidMailer
      class Engine < Rails::Engine
        extension_name "LiquidMailer", {:action=>"index", :controller=>"admin/liquid_mailers"}
        
        def self.activate

        end

        config.to_prepare &method(:activate).to_proc

        config.after_initialize do

        end
      end
    end
  end
end