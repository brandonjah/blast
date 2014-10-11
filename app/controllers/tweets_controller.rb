class TweetsController < ApplicationController
  def new
  	@tweet = Tweet.new
  end

  def create
  	tweet = Tweet.where(id: params[:tweet][:id]).first_or_create
  	tweet.update_attributes(twitter_params)
    current_user.send_tweet(tweet,current_user.uid)
  end

  def twitter_params
    params.require(:tweet).permit(:message, :user_id, :content_id, content_attributes: [:id, :name, :post, :post_time])
  end
end