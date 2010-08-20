require 'sinatra'
require 'sinatra/reloader' if development?
require 'helper'
require 'coderay'

include Helper

MONGODB_DRIVERS = [:mongo_ruby_driver, :mongoid, :mongo_mapper]

MONGODB_DRIVERS.each {|driver| require "examples/#{driver}_example.rb"}

get /.*/ do
  @driver = :mongo_ruby_driver
  haml :index
end

post "/add" do
  puts params.inspect
  @driver = params[:driver].to_sym
  @post_id = params[:post_id]
  
  unless @post_id.empty?
    @twitter_post = load_post_from_twitter(@post_id)
    @ruby_source = File.read("examples/#{@driver}_example.rb")
    case @driver
    when :mongo_ruby_driver  
      @mongo_id = MongoRubyDriverExample.save(@twitter_post)
      @mongo_data = MongoRubyDriverExample.load(@mongo_id)
    when :mongoid
      @mongo_id = MongoidExample.save(@twitter_post)
      @mongo_data = MongoidExample.load(@mongo_id)
    when :mongo_mapper
      @mongo_id = MongoMapperExample.save(@twitter_post)
      @mongo_data = MongoMapperExample.load(@mongo_id)
    end
  else 
    @error = "Can haz driver and post_id!"
  end
  
  haml :index
end
