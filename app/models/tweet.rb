require 'date'
require 'net/http'
require 'uri'
require 'json'

class Tweet
  attr_accessor :search_word, :json

  def initialize(search_word, json)
    @search_word = search_word
    @json = json
  end

  def self.list(search_word, number)
    uri = URI.parse("https://api.twitter.com/1.1/search/tweets.json")
    query = {
      "q"           => search_word, 
      "count"       => number,
      "lang"        => "ja",
      "result_type" => "recent"
    }
    uri.query = query.map { |key, value| "#{key}=#{value}" }.join("&")
  
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    header = {"Authorization" => "Bearer #{ENV['TWITTER_BEARER_TOKEN']}"}
  
    response = http.get(uri.request_uri, header)

    JSON.parse(response.body)["statuses"].each_with_object([]) do |json, tweets|
      tweets << self.new(search_word, json)
    end
  end
  
  def user_id
    @json["user"]["screen_name"]
  end

  def user_name
    @json["user"]["name"]
  end

  def user_url
    "https://twitter.com/#{user_id}"
  end

  def user_image_url
    @json["user"]["profile_image_url"]
  end

  def url
    "https://twitter.com/#{user_id}/status/#{@json["id"]}"
  end

  def text
    @json["text"]
  end

  def created_at
    DateTime.parse(@json["created_at"]).new_offset("+0900").strftime("%Y/%m/%d %R")
  end
end