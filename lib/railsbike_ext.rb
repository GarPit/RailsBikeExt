require 'railsbike_ext/integrator'
require 'railsbike_ext/engine'
Dir[File.join(File.dirname(__FILE__), 'core', '**/engine.rb')].each { |lib| require lib }
require 'railsbike_ext/liquid'
require 'railsbike_ext/mongoid_fulltext'
require 'railsbike_ext/export'

module RailsbikeExt
  
end