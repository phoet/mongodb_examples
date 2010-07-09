require 'mongo_mapper' 
require 'pp'

# source
# http://github.com/jnunemaker/mongomapper
# tutorial
# http://railstips.org/blog/archives/2009/06/27/mongomapper-the-rad-mongo-wrapper/

MONGO_URL = "mongodb://#{ENV['MONGOHQ_USER']}:#{ENV['MONGOHQ_PASS']}@flame.mongohq.com:#{ENV['MONGOHQ_PORT']}/#{ENV['MONGOHQ_DB']}"
puts "Opening connection to #{MONGO_URL}"

class Person
  include MongoMapper::Document

  key :first_name, String
  key :last_name, String
  key :age, Integer
  key :born_at, Time
  key :active, Boolean
  key :fav_colors, Array

  connection Mongo::Connection.from_uri(MONGO_URL)
  set_database_name 'basement'
end

Person.delete_all

person = Person.create({
  :first_name => 'John',
  :last_name => 'Nunemaker',
  :age => 27,
  :born_at => Time.mktime(1981, 11, 25, 2, 30),
  :active => true,
  :fav_colors => %w(red green blue)
})

person.first_name = 'Johnny'
person.save

Person.all.each do |p|
  pp p
end
