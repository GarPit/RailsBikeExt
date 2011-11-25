require 'qu'
require 'qu-mongo'
Qu.configure do |c|
  c.connection = Mongo::Connection.new('', 27017).db(Mongoid.master.name)
end