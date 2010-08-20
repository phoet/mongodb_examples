# 
# require 'mongoid' 
# 
# class MongoidExample
#   
#   def self.save(twitter_post)
#     connect
#     MongoidUser.delete_all
# 
#     user = MongoidUser.new(twitter_post['user'])
#     user.save
#     
#     tweet = MongoidTweet.new 
#     tweet.mongoid_user = user
#     tweet.geo = twitter_post['geo']
#     tweet.text = twitter_post['text']
#     tweet.created_at = twitter_post['created_at']
#     tweet.save
#     user.id
#   end
#   
#   def self.load(mongo_id)
#     connect
#     MongoidUser.criteria.id(mongo_id).first
#   end
#   
#   def self.connect
#     puts "opening connection to #{ENV['MONGOHQ_URL']}"
#     uri = URI.parse(ENV['MONGOHQ_URL'])
#     conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
#     Mongoid.database = conn.db(uri.path.gsub(/^\//, ''))
#   end
# end
# 
# class MongoidUser
#   include Mongoid::Document 
#   field :description
#   field :followers_count, :type => Integer
#   field :protected, :type => Boolean
#   field :screen_name
#   field :url
#   field :name
#   field :created_at, :type => DateTime
#   
#   embeds_many :mongoid_tweets 
# end 
# 
# class MongoidTweet
#   include Mongoid::Document 
#   field :geo
#   field :text
#   field :created_at, :type => DateTime
# 
#   embedded_in :mongoid_user, :inverse_of => :mongoid_tweets 
# end
