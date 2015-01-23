class SessionsController < ApplicationController
  def create
    # puts "in create env: #{env.inspect} request: #{request.inspect}"
    user = User.from_omniauth(request.env["omniauth.auth"])
    puts user.inspect
    session[:user_id] = user.id
    # redirect_to root_url, notice: "Signed in!"
    if user.provider == "twitter"
    	redirect_to request.env['omniauth.origin'] || root_url#, notice: "Signed in!"
    elsif user.provider == "identity"
    	redirect_to contents_url
    else
    	redirect_to root_url
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
end