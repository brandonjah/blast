class User < ActiveRecord::Base
  has_many :tweets

  def self.from_omniauth(auth)
    p "auth in from from_omniauth; #{auth}"
    if auth.provider == "twitter"
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        %w[provider uid].each do |a|
          user.send("#{a}=", auth.send("#{a}"))
        end
        user.name     = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_secret = auth.credentials.secret
        user.save
      end
    elsif auth.provider == "facebook"
      access_token = auth['credentials']['token']
      facebook = Koala::Facebook::API.new(access_token)
      facebook.get_object("me?fields=name,email")
    end
  end

  def self.koala(auth)
    access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
    facebook.get_object("me?fields=name,email")
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
    # client.delay(run_at: tweet.content.post_time).update(tweet.message)
    client.delay(run_at: tweet.content.post_time.in_time_zone(tweet.content.time_zone)).update(tweet.message)
  end

  def self.when_to_run
  end
  # handle_asynchronously :tweet, :run_at => Proc.new { 5.minutes.from_now }
  # handle_asynchronously :tweet, :run_at => Proc.new { when_to_run }
end