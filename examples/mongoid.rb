require 'mongoid' 
require 'pp'

# simple tutorial 
# http://rujmah.posterous.com/using-mongoid-without-rails
# great documentation
# http://mongoid.org/docs/documents/
# project site
# http://github.com/durran/mongoid

p Mongoid.database = Mongo::Connection.new('flame.mongohq.com',ENV['MONGOHQ_PORT']).db(ENV['MONGOHQ_DB'])
Mongoid.database.authenticate(ENV['MONGOHQ_USER'],ENV['MONGOHQ_PASS'])

class Tweeter 
  include Mongoid::Document 
  field :user 
  embeds_many :tweets 
end 

class Tweet 
  include Mongoid::Document 
  field :status 

  embedded_in :tweeter, :inverse_of => :tweets 
end 

Tweeter.delete_all

puts "just create user"
user = Tweeter.new(:user => 'bill') 
user.save 

puts "create tweet and user"
tweet = Tweet.new(:status => "This is a tweet!") 
tweet.tweeter = Tweeter.new(:user => 'ted') 
tweet.save

puts "all tweeter"
Tweeter.all.each do |tweeter| 
  pp tweeter
  pp tweeter.tweets
end