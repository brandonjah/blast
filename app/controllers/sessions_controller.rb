class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end
  
  def new
		redirect_to '/auth/twitter'
	end

	def destroy
		reset_session
		redirect_to root_url, :notice => 'Signed out!'
	end

	def failure
		redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
	end
end