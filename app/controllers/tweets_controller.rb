class TweetsController < ApplicationController
  def new
  end

  def create
  	tweet = Tweet.create(twitter_params)
    current_user.tweet(tweet,current_user.uid)
  end

  def twitter_params
    params.require(:tweet).permit(:message, :user_id, content_attributes: [:id, :name])
  end
end