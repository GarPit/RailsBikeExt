puts ".. loading RailsbikeExt engine"

require 'yaml'
YAML::ENGINE.yamler = 'syck'
#--
require 'rails'
require 'mongoid'
require 'haml'
require 'railsbike_ext/railsbike_engine'
require 'railsbike_ext/engine_ext'


$:.unshift File.dirname(__FILE__)
RailsbikeExt::RailsbikeEngine.send :include, RailsbikeExt::EngineExt

module RailsbikeExt
  class RailsbikeExt < Rails::Engine
    #include EngineExt
    
    #extension_name "RailsbikeCore", "#"
    
    def self.activate
      #Locomotive.configure do |config|
      #  config.locales = %w{en ru}
      #end
      
      Locomotive::Liquid::Drops::Page.send(:include, ::RailsbikeExt::Drops::PageExt)
      Locomotive::Liquid::Drops::ProxyCollection.send(:include, ::RailsbikeExt::Drops::ProxyCollectionExt)
      Locomotive::Liquid::Drops::Site.send(:include, ::RailsbikeExt::Drops::SiteExt)
      require 'railsbike_ext/extended'
      
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end
    
    config.autoload_once_paths += %W( #{config.root}/app/controllers #{config.root}/app/models #{config.root}/app/helpers #{config.root}/app/uploaders)
    
    config.to_prepare &method(:activate).to_proc
    
    config.after_initialize do
      #ContentInstance.send :include, Extensions::Sphinx
      begin
        ::RailsbikeExt::SphinxIntegrator.instance.update_dynamic_search_indexes
      rescue Exception => e
        
      end      
      Page.send :include, Extensions::Pagenav
    end
  end
end