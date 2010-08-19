require 'sinatra'
require 'sinatra/reloader' if development?
require 'helper'
require 'coderay'
require 'ap'
require 'ap/mixin/action_view.rb'

include Helper

#MONGODB_DRIVERS = [:mongo_ruby_driver, :mongoid, :mongo_mapper]
MONGODB_DRIVERS = [:mongo_ruby_driver]

MONGODB_DRIVERS.each {|driver| require "examples/#{driver}.rb"}

get /.*/ do
  @driver = :mongo_ruby_driver
  haml :index
end

post "/add" do
  puts params.inspect
  @driver = params[:driver]
  @post_id = params[:post_id]
  
  unless @post_id.empty?
    @driver = @driver.to_sym
    @twitter_post = load_post_from_twitter(@post_id)
    @ruby_source = File.read("examples/#{@driver}.rb")
    if(@driver == :mongo_ruby_driver)
      puts "saving stuff with mrd"
      @mongo_id = MongoRubyDriver.save(@twitter_post)
      @mongo_data = MongoRubyDriver.load(@mongo_id)
    else
      puts "unknown driver"
    end
  else 
    @error = "Can haz driver and post_id!"
  end
  
  haml :index
end
