require 'uri'
require 'mongo'
require 'pp'

mongo_url = "mongodb://#{ENV['MONGO_USER']}:#{ENV['MONGO_PASS']}@#{ENV['MONGO_HOST']}:#{ENV['MONGO_PORT']}/#{ENV['MONGO_DB']}"

puts "Opening connection to #{mongo_url}"
uri = URI.parse(mongo_url)
conn = Mongo::Connection.from_uri(mongo_url)
db = conn.db(uri.path.gsub(/^\//, ''))

coll = db.collection('test')

puts "Removing all records"
coll.remove

puts "Insert a record"
coll.insert('a' => 1)

puts "There are #{coll.count()} records."
coll.find().each { |row| pp row }