require 'qu'
require 'qu-mongo'
Qu.configure do |c|
  c.connection = Mongo::Connection.new('', 27017).db("myapp-#{Rails.env}")
end