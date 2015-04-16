class TweetsController < ApplicationController
  def new
  	@tweet = Tweet.new
  end

  def create
  	tweet = Tweet.where(id: params[:tweet][:id]).first_or_create
  	tweet.update_attributes(twitter_params)
    current_user.send_tweet(tweet,current_user.uid) if current_user
    current_facebook_user.post_to_facebook(tweet,current_facebook_user.uid) if current_facebook_user
  end

  def twitter_params
    params.require(:tweet).permit(:message, :user_id, :content_id, content_attributes: [:id, :name, :post, :post_time])
  end
end