require "rubygems"
require "bundler"
require "haml"
require 'mongo_mapper'

Bundler.setup

require 'examples_app'
run Sinatra::Application
