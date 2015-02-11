class User < ActiveRecord::Base
  has_many :tweets

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      %w[provider uid].each do |a|
        user.send("#{a}=", auth.send("#{a}"))
      end
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
    p "post time in user"
    p tweet.content.post_time
    p "time using in_time_zone"
    p Time.zone.parse(tweet.content.post_time.to_s).utc.in_time_zone(tweet.content.time_zone)
    p "use time zone"
    p tweet.content.post_time.in_time_zone(tweet.content.time_zone)
    p "in pacific time"
    p tweet.content.post_time.in_time_zone("Pacific Time (US & Canada)")
    # ["run_at", "2015-02-07 23:02:00.000000"]?
    # client.delay(run_at: tweet.content.post_time).update(tweet.message)
    client.delay(run_at: tweet.content.post_time.in_time_zone(tweet.content.time_zone)).update(tweet.message)
  end

  def self.when_to_run
  end
  # handle_asynchronously :tweet, :run_at => Proc.new { 5.minutes.from_now }
  # handle_asynchronously :tweet, :run_at => Proc.new { when_to_run }
end