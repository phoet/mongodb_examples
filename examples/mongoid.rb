
require 'mongoid' 

class MongoidExample
  
  def self.save(twitter_post)
    connect
    User.delete_all

    user = User.new(twitter_post['user'])
    user.save
    

    tweet = Tweet.new 
    tweet.user = user
    tweet.geo = twitter_post['geo']
    tweet.text = twitter_post['text']
    tweet.created_at = twitter_post['created_at']
    tweet.save
    user.id
  end
  
  def self.load(mongo_id)
    connect
    User.all.each do |tweeter| 
      p tweeter
      p tweeter.tweets
    end
    
    User.criteria.id(mongo_id).first
  end
  
  def self.connect
    puts "opening connection to #{ENV['MONGOHQ_URL']}"
    uri = URI.parse(ENV['MONGOHQ_URL'])
    conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    Mongoid.database = conn.db(uri.path.gsub(/^\//, ''))
  end
end

class User 
  include Mongoid::Document 
  field :description
  field :followers_count, :type => Integer
  field :protected, :type => Boolean
  field :screen_name
  field :url
  field :name
  field :created_at, :type => DateTime
  
  embeds_many :tweets 
end 

class Tweet 
  include Mongoid::Document 
  field :geo
  field :text
  field :created_at, :type => DateTime

  embedded_in :user, :inverse_of => :tweets 
end
