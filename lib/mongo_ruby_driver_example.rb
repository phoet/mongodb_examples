require 'uri'

class MongoRubyDriverExample
  
  def self.save(twitter_post)
    coll = connect
    coll.remove
    coll.insert(twitter_post)
  end
  
  def self.load(id)
    coll = connect
    coll.find({"_id" => id}, {}).first
  end
  
  def self.connect
    uri = URI.parse(ENV['MONGOHQ_URL'])
    conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    db = conn.db(uri.path.gsub(/^\//, ''))
    coll = db.collection(self.class.to_s)
  end
end