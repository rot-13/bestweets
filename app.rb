require 'sinatra'
require 'sinatra/json'
require 'twitter'
require 'dotenv'

Dotenv.load

TWITTER_CONFIG = {
  consumer_key: ENV['CONSUMER_KEY'],
  consumer_secret: ENV['CONSUMER_SECRET']
}

TWITTER_CLIENT = Twitter::REST::Client.new(TWITTER_CONFIG)

def fetch_tweets(user)
  tweets = []
  tweets.concat(next_tweets = TWITTER_CLIENT.user_timeline(user, count: 200))
  until next_tweets.size < 200
    max_id = next_tweets.last.id - 1
    tweets.concat(next_tweets = TWITTER_CLIENT.user_timeline(user, count: 200, max_id: max_id))
  end
  tweets
end

def top_10(tweets)
  tweets.reject do |tweet| 
    tweet.retweet? || tweet.reply?
  end.sort_by do |tweet|
    (tweet.favorite_count + tweet.retweet_count) * -1
  end.first(10).map do |tweet|
    TWITTER_CLIENT.oembed(tweet, omit_script: true, align: 'center', maxwidth: 550).html
  end
end

get '/' do
  haml :index
end

get '/:username' do
  json tweets: top_10(fetch_tweets(params[:username]))
end
