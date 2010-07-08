require 'uri'
require 'mongo'
require 'pp'

# some advise for connection
# http://docs.heroku.com/mongohq#using-mongo-ruby-driver
# driver documentation
# http://github.com/mongodb/mongo-ruby-driver

mongo_url = "mongodb://#{ENV['MONGOHQ_USER']}:#{ENV['MONGOHQ_PASS']}@flame.mongohq.com:#{ENV['MONGOHQ_PORT']}/#{ENV['MONGOHQ_DB']}"

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