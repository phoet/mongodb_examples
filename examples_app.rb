require 'sinatra'
require 'sinatra/reloader' if development?
require 'helper'
require 'coderay'

include Helper

MONGODB_DRIVERS = [:mongo_ruby_driver, :mongoid, :mongo_mapper]

get /.*/ do
  haml :index
end

post "/add" do
  puts params
  @driver = params[:driver]
  @post_id = params[:post_id]
  puts ENV['MONGOHQ_URL']
  
  if @driver && @post_id
    @twitter_post = load_post_from_twitter(@post_id)
    @ruby_source = File.read("examples/#{@driver}.rb")
  else 
    @error = "Can haz driver and post_id!"
  end
  
  haml :index
end