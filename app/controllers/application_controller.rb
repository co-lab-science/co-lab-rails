class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :redirect_signed_in_user

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_signed_in_user
    redirect_to root_url if current_user
  end
end
