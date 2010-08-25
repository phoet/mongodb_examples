require File.dirname(__FILE__) + '/spec_helper'
require File.join(File.dirname(__FILE__), '..', 'lib', 'examples_app.rb')

describe 'Examples App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
  
  it "should have mongo ruby driver set" do
    get '/'
    last_response.body.should =~ /checked='checked' name='driver' type='radio' value='mongo_ruby_driver'/
  end
  
  it "should halt an error if no params set" do
    post '/add'
    last_response.status.should == 500
  end
  
  it "should print an error if no id set" do
    post '/add', :driver => :mongo_ruby_driver
    last_response.should be_ok
    last_response.body.should =~ /Can haz driver and post_id!/
  end
end