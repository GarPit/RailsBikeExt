puts ".. loading Railsbike-sitemap engine"

require 'rails'

module Railsbike
  module Core
    module Sitemap
      class Engine < Rails::Engine
        extension_name "Sitemap", {:action=>"index", :controller=>"admin/tree_templates"}
        
        def self.activate

        end

        config.to_prepare &method(:activate).to_proc

        config.after_initialize do

        end
      end
    end
  end
end