class UsersController < ApplicationController
  before_action :redirect_signed_in_user, only: [:new]
  before_action :redirect_if_not_admin, only: [:index, :edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.all
    render '/admin/users/index'
  end

  def edit
    @user = User.find(params[:id])
    render '/admin/users/edit'
  end

  def show
    @user = User.find(params[:id])
    @content = []
    if params[:content]
      @content = Object.const_get(params[:content].capitalize).where(user_id: @user.id).order(created_at: :desc).paginate(per_page: 50, page: params[:page])
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save
    redirect_to edit_user_path(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render 'new'
    end
  end

  def join_new_group
    @user = User.find(params[:user][:id])
    if params[:user][:group_id] == 1
      @user.group_id = params[:user][:group_id]
      @user.requested_group = nil
    elsif params[:user][:approved] == "yes"
      @user.group_id = params[:user][:group_id]
      @user.requested_group = nil
    else
      @user.requested_group = params[:user][:group_id]
    end
    @user.save
    redirect_to "/users/#{@user.id}"
  end

  private

  def redirect_if_not_admin
    redirect_to root_path if (!current_user.admin rescue true)
  end

  def user_params
    defaults = { group: '1', group_id: 1 }
    params.require(:user).permit(:name, :email, :password, :group, :group_id, :requested_group, :specialities_attributes => [:id, :category, :rank])
  end
end
