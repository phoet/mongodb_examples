require 'httpclient'
require 'crack/json'

module Helper

  def load_post_from_twitter(post_id)
    resp = HTTPClient.new.get_content "http://#{ENV['APIGEE_TWITTER_API_ENDPOINT']}/1/statuses/show/#{post_id}.json"
    Crack::JSON.parse resp
  end
  
end