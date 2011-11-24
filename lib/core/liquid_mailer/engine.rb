puts ".. loading Railsbike-LiquidMailer engine"
module Railsbike
  module Core
    module LiquidMailer
      class Engine < RailsbikeExt::RailsbikeEngine
        extension_name "LiquidMailer", {:action=>"index", :controller=>"admin/liquid_mailers"}
      end
    end
  end
end