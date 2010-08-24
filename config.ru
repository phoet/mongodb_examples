$:.unshift ::File.join(::File.dirname(__FILE__), 'lib')

require "rubygems"
require "bundler"

Bundler.setup

require 'sinatra'
require 'sinatra/reloader' if development?
require 'examples_app'
run Sinatra::Application
