class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_facebook_user
  helper_method :user_signed_in?
  helper_method :social_media_user?
  helper_method :correct_user?
  helper_method :admin_user?
  
  has_mobile_fu false

  def facebook_cookies
    @facebook_cookies ||= Koala::Facebook::OAuth.new(ENV["BLAST_FACEBOOK_KEY"], ENV["BLAST_FACEBOOK_SECRET"]).get_user_info_from_cookie(cookies)
  end
  
  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def current_facebook_user
      begin
        @current_user ||= User.find(session[:facebook_user_id]) if session[:facebook_user_id]
      rescue Exception => e
        nil
      end
    end

    def social_media_user?
      if current_user || current_facebook_user
        true
      end
    end    

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def admin_user?
      if current_user
        current_user.provider == "identity" ? true : false
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

end
  # protect_from_forgery with: :exception
  
  # private
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  # helper_method :current_user  