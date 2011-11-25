require 'daemon_spawn'
Dir[File.join(File.dirname(__FILE__), 'jobs', '*.rb')].each { |lib| require lib }