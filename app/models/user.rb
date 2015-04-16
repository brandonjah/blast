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
      user.save!
    end
  end

  def self.koala(access_token)
    # access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
    auth = facebook.get_object("me?fields=name,email")
    where(provider: "facebook", uid: auth['id']).first_or_create do |user|
      user.name     = auth['name']
      user.provider     = auth['provider']
      user.id     = auth['id']
      user.save!
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
    # client.delay(run_at: tweet.content.post_time).update(tweet.message)
    client.delay(run_at: tweet.content.post_time.in_time_zone(tweet.content.time_zone)).update(tweet.message)
  end

  def post_to_facebook(post,uid)
    user = User.find_by(uid: uid)
    # get long lived token, save it on the user, then get @graph using this token
    @graph = Koala::Facebook::API.new user.oauth_token
    @graph.delay(run_at: post.content.post_time.in_time_zone(post.content.time_zone)).put_wall_post(post.message)
  end
  # handle_asynchronously :tweet, :run_at => Proc.new { 5.minutes.from_now }
  # handle_asynchronously :tweet, :run_at => Proc.new { when_to_run }
end