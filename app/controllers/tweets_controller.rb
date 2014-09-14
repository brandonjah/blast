class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.tweet(twitter_params[:message],current_user.uid)
    Tweet.create(twitter_params)
  end

  def twitter_params
    params.require(:tweet).permit(:message, user_attributes: [:id], content_attributes: [:id])
  end
end