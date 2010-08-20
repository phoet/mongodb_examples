require "rubygems"
require "bundler"

Bundler.setup

require 'examples_app'
run Sinatra::Application
