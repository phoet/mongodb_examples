$:.unshift ::File.join(::File.dirname(__FILE__), 'lib')

require "rubygems"
require "bundler"

Bundler.setup

require 'sinatra'

configure :development do
  Sinatra::Application.reset!
  use Rack::Reloader
end

require 'examples_app'
run Sinatra::Application
