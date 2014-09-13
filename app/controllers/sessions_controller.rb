class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end
  
  # def destroy
  #   session[:user_id] = nil
  #   redirect_to root_url, notice: "Signed out!"
  # end
  def new
		redirect_to '/auth/twitter'
	end

	# def create
	# 	puts User.inspect
	# 	auth = request.env["omniauth.auth"]
	# 	user = User.where(:provider => auth['provider'],
	# 	:uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
	# 	reset_session
	# 	session[:user_id] = user.id
	# 	redirect_to root_url, :notice => 'Signed in!'
	# end

	def destroy
		reset_session
		redirect_to root_url, :notice => 'Signed out!'
	end

	def failure
		redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
	end
end