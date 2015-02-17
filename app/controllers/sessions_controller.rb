class SessionsController < ApplicationController
  def create
    if params[:provider] == "facebook"
      # @user = User.koala(params['authResponse']['access_token'])
      # @access_token = facebook_cookies['access_token']
      @graph = Koala::Facebook::GraphAPI.new(session_params[:data])
      @graph.put_wall_post("test post")
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
    params.permit(:data)
  end
end