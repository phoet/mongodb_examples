
require 'mongo'
require 'pp'

puts "Opening connection to #{mongo_url}"
conn = Mongo::Connection.from_uri(mongo_url)
db = conn.db(ENV['MONGO_DB'])

coll = db.collection('test')

puts "Removing all records"
coll.remove

puts "Insert a record"
coll.insert('a' => 1)

puts "There are #{coll.count()} records."
coll.find().each { |row| pp row }