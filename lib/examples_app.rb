require 'helper'
require 'coderay'

include Helper

MONGODB_DRIVERS = {
  :mongo_ruby_driver => :MongoRubyDriverExample,
  :mongoid => :MongoidExample,
  :mongo_mapper => :MongoMapperExample,
}

get /.*/ do
  @driver = :mongo_ruby_driver
  haml :index
end

post "/add" do
  halt 500 if params[:driver].nil?
  
  @driver = params[:driver].to_sym
  @post_id = params[:post_id]
  
  unless @post_id.nil? || @post_id.empty?
    @twitter_post = load_post_from_twitter @post_id
    @ruby_source = load_file @driver
    
    driver_class = MONGODB_DRIVERS[@driver]
    autoload driver_class, "#{@driver}_example"
    driver_class_instance = Kernel.const_get driver_class.to_s
    @mongo_id = driver_class_instance.send :save, @twitter_post
    @mongo_data = driver_class_instance.send :load, @mongo_id
  else 
    @error = "Can haz driver and post_id!"
  end
  
  haml :index
end
