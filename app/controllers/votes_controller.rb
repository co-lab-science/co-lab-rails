class VotesController < ApplicationController
  before_action :validate_voter

  def create
    @vote = vote_type.new(vote_params)
    if @vote.save
      render json: { vote: @vote }, status: :ok
    else
      render json: {}, status: :internal_server_error
    end
  end

  def destroy
    find_param = vote_params.to_h
    find_param.delete :id
    @vote = vote_type.find_by(find_param)
    @vote.destroy
    render json: { vote: @vote }, status: :ok
  end

  private

  def validate_voter
    render json: {}, status: :internal_server_error if current_user.id != params[:user_id].to_i
  end

  def voted?
    vote_type.exists?(vote_params.to_h)
  end

  def vote_type
    params[:vote_type].capitalize.constantize
  end

  def vote_params
    params.permit(:question_id, :user_id, :comment_id, :id, :lab_id, :hypothesis_id)
  end
end

