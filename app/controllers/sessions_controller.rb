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

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "logged out"
  end
end
