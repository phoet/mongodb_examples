$:.unshift ::File.join(::File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'bundler'

Bundler.require

configure :development do
  Sinatra::Application.reset!
  use Rack::Reloader
end

configure do
  set :root, File.dirname(__FILE__)
  set :views, File.dirname(__FILE__) + "/views"
end

require 'examples_app'
run Sinatra::Application
