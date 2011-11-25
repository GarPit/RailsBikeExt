require 'daemon_spawn'
Dir[File.join(File.dirname(__FILE__), 'daemons', '*.rb')].each { |lib| require lib }