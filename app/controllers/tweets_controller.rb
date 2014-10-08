class TweetsController < ApplicationController
  def new
  	@tweet = Tweet.new
  end

  def create
  	# if params[:tweet].has_key? :id
  	# 	puts "has key id : #{params.inspect}"
  	# 	tweet = Tweet.find(params[:tweet][:id])
  	# else
  	# 	puts "no has key id : #{params.inspect}"
			# tweet = Tweet.create(twitter_params)
  	# end
  	tweet = Tweet.where(id: params[:tweet][:id]).first_or_create
  	tweet.update_attributes(twitter_params)
  	puts "tweet in controller create: #{tweet.inspect}"
    current_user.send_tweet(tweet,current_user.uid)
  end

  def twitter_params
    params.require(:tweet).permit(:message, :user_id, :content_id, content_attributes: [:id, :name, :post, :post_time])
  end
end