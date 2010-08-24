require 'httpclient'
require 'crack/json'

module Helper

  def load_post_from_twitter(post_id)
    resp = HTTPClient.new.get_content "http://#{ENV['APIGEE_TWITTER_API_ENDPOINT']}/1/statuses/show/#{post_id}.json"
    Crack::JSON.parse resp
  rescue
    {"error" => "an error occured loading tweet #{post_id} (#{$!})"}
  end
  
  def load_file(driver_name)
    File.read(File.join(::File.dirname(__FILE__), "#{driver_name}_example.rb"))
  end
  
end