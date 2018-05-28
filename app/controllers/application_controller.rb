class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
  helper_method :redirect_signed_in_user, :authenticate


  def redirect_signed_in_user
    redirect_to root_url if current_user
  end

  def authenticate
    render json: { error: 'Access denied' } if !current_user
  end
end
