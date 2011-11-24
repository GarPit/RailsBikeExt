puts ".. loading Railsbike-sitemap engine"

require 'rails'

module Railsbike
  module Core
    module Sitemap
      class Engine < RailsbikeExt::RailsbikeEngine
        extension_name "Sitemap", {:action=>"index", :controller=>"admin/tree_templates"}
      end
    end
  end
end