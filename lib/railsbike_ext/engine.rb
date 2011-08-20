puts ".. loading RailsbikeExt engine"

require 'rails'
require 'mongoid'
require 'haml'
require 'railsbike_ext/engine_ext'


$:.unshift File.dirname(__FILE__)
Rails::Engine.send :include, RailsbikeExt::EngineExt

module RailsbikeExt
  class RailsbikeExt < Rails::Engine
    
    extension_name "RailsbikeCore", "#"
    
    def self.activate
      Locomotive.configure do |config|
        config.locales = %w{en ru}
      end
      Locomotive::Liquid::Drops::Page.send(:include, ::RailsbikeExt::Drops::PageExt)
    end
    
    config.autoload_once_paths += %W( #{config.root}/app/controllers #{config.root}/app/models #{config.root}/app/helpers #{config.root}/app/uploaders)
    
    config.to_prepare &method(:activate).to_proc
    
    config.after_initialize do
      ContentInstance.send :include, Extensions::Sphinx
    end
  end
end