require 'sinatra'
require "sinatra/reloader" if development?

get /.*/ do
  haml :index
end

post "/add" do
  puts params
  @name = params[:name]
  @text = params[:text]
  haml :index
end