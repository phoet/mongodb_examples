require 'sinatra'
require "sinatra/reloader" if development?

MONGODB_DRIVERS = [:mongo_ruby_driver, :mongoid, :mongo_mapper]

get /.*/ do
  haml :index
end

post "/add" do
  puts params
  @driver = params[:driver]
  @post_id = params[:post_id]
  haml :index
end