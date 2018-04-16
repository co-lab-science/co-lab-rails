class SessionsController < ApplicationController
  before_action :redirect_signed_in_user, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "logged in"
    else
      flash.now.alert = "Email or password was invalid"
      render "new"
    end
  end

  # test method for omniauth
  def createOmni
    auth_hash = request.env["omniauth.auth"]

    if session[:user_id]
      # User signed in, add new provider
      User.find(session[:user_id]).add_provider(auth_hash)
    else
      # log in or sign up
      auth = Authorization.find_or_create(auth_hash)

      #create the session
      session[:user_id] = auth.user.id
    end
  end

  def failure
    # logic to show a failure on social auth
  end

  # def githubAuth
  #   user = User.find_by()
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "logged out"
  end
end
