
require 'mongo_mapper'

# monkey patchin!
module MongoMapper
  module Plugins
    def plugins
      @plugins ||= []
    end

    def plugin(mod)
      # extend mod::ClassMethods     if mod.const_defined?(:ClassMethods)
      # include mod::InstanceMethods if mod.const_defined?(:InstanceMethods)
      # for whatever reason mod.const_defined?(:ClassMethods) doesn't work hence this workaround
      extend mod::ClassMethods     if mod.constants.include?(:ClassMethods)
      include mod::InstanceMethods if mod.constants.include?(:InstanceMethods)
      mod.configure(self)          if mod.respond_to?(:configure)
      plugins << mod
    end
  end
end

class MongoMapperExample

  def self.save(twitter_post)
    MongoMapperUser.delete_all

    user = MongoMapperUser.new
    user.description = twitter_post['user']['description']
    user.followers_count = twitter_post['user']['followers_count']
    user.protected = twitter_post['user']['protected']
    user.screen_name = twitter_post['user']['screen_name']
    user.url = twitter_post['user']['url']
    user.name = twitter_post['user']['name']
    user.created_at = twitter_post['user']['created_at']
    
    tweet = MongoMapperTweet.new
    tweet.geo = twitter_post['geo']
    tweet.text = twitter_post['text']
    tweet.created_at = twitter_post['created_at']
    user.mongo_mapper_tweets << tweet
    user.save
    user.id
  end

  def self.load(mongo_id)
    MongoMapperUser.find(mongo_id)
  end

end

class MongoMapperTweet 
  include MongoMapper::EmbeddedDocument

  key :geo, String
  key :text, String
  key :created_at, DateTime
end
  
class MongoMapperUser
  include MongoMapper::Document

  key :description, String
  key :followers_count, Integer
  key :protected, Boolean
  key :screen_name, String
  key :url, String
  key :name, String
  key :created_at, DateTime

  many :mongo_mapper_tweets

  connection Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  set_database_name URI.parse(ENV['MONGOHQ_URL']).path.gsub(/^\//, '')
end