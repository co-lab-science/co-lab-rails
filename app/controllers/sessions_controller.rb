class SessionsController < ApplicationController
  before_action :redirect_signed_in_user, only: [:new]

  def new
  end

  # test method for omniauth
  def create
    auth_hash = request.env['omniauth.auth']

    render :text, auth_hash.inspect
  end

  # def create
  #   user = User.find_by(email: params[:email])
  #   if user && user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     redirect_to root_url, notice: "logged in"
  #   else
  #     flash.now.alert = "Email or password was invalid"
  #     render "new"
  #   end
  # end

  def failure
    # logic to show a failure on social auth
  end

  def githubAuth
    user = User.find_by()
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "logged out"
  end
end
