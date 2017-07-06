class SpecialitiesController < ApplicationController
  before_action :redirect_if_not_admin

  def create
    Speciality.create(speciality_params)
    redirect_to edit_user_path(params[:user_id])
  end

  def new
    @speciality = Speciality.new
    render 'admin/users/specialities/new'
  end

  private
    def redirect_if_not_admin
      redirect_to root_path if (!current_user.admin rescue true)
    end

  def speciality_params
    params.require(:speciality).permit(:rank, :category).to_h.merge(user_id: params[:user_id])
  end
end
