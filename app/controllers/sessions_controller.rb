class SessionsController < ApplicationController
  def create
    if params[:provider] == "facebook"
      # @user = User.koala(params['authResponse']['access_token'])
      # @access_token = facebook_cookies['access_token']
      user = User.koala(session_params[:token])
      session[:facebook_user_id] = user.id
      oauth = Koala::Facebook::OAuth.new(ENV["BLAST_FACEBOOK_KEY"], ENV["BLAST_FACEBOOK_SECRET"])
      new_access_info = oauth.exchange_access_token_info session_params[:token]
      new_access_token = new_access_info["access_token"]
      user.oauth_token = new_access_token
      user.save!
      # @graph.put_wall_post("test post")
      return render nothing: true
    else
      # puts "in create env: #{env.inspect} request: #{request.inspect}"
      user = User.from_omniauth(request.env["omniauth.auth"])
      puts user.inspect
      session[:user_id] = user.id
      # redirect_to root_url, notice: "Signed in!"
      if user.provider == "twitter"
      	redirect_to request.env['omniauth.origin'] || root_url#, notice: "Signed in!"
      elsif user.provider == "identity"
      	redirect_to contents_url
      elsif user.provider == "facebook"
        # @user = User.koala(request.env['omniauth.auth']['credentials'])
        @access_token = facebook_cookies['access_token']
        @graph = Koala::Facebook::GraphAPI.new(@access_token)
        @graph.put_wall_post("test post")
      else
      	redirect_to root_url
      end
    end
  end
  
  def new
		redirect_to '/auth/twitter'
	end

	def destroy
		reset_session
		redirect_to request.env['omniauth.origin'] || root_url#, :notice => 'Signed out!'
	end

	def failure
		redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
	end

  def session_params
    params.permit(:token)
  end
end