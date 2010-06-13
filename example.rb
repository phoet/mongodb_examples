require 'uri'
require 'mongo'
require 'pp'

# mongodb://USER:PASSWORD@flame.mongohq.com:PORT/DATABASE
mongo_url = ENV['MONGOHQ_URL']

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