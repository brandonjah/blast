class UsersController < ApplicationController
	respond_to :json

	def show
		# @user = User.find_by_id(user_params[:id])
		respond_with User.find_by_id(user_params[:id])
	end

  def login
    @user = User.koala(request.env['omniauth.auth']['credentials'])
  end	

  def user_params
    # params.require(:user).permit(:id, :name)
    params.permit(:id, :name)
  end	
end