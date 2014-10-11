class User < ActiveRecord::Base
  has_many :tweets

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save
    end
  end

  def send_tweet(tweet,uid)
    user = User.find_by(uid: uid)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end
    
    # client.update(tweet)
    client.delay(run_at: tweet.content.post_time).update(tweet.message)
  end

  def self.when_to_run
  end
  # handle_asynchronously :tweet, :run_at => Proc.new { 5.minutes.from_now }
  # handle_asynchronously :tweet, :run_at => Proc.new { when_to_run }
end