class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
  helper_method :current_user, :redirect_signed_in_user, :authenticate

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_signed_in_user
    redirect_to root_url if current_user
  end

  def authenticate
    render json: { error: 'Access denied' } if !current_user
  end
end
