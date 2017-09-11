class LikesController < ApplicationController
  before_action :validate_liker

  def create
    like_create_count.times do
      like_type.create(hypothesis_id: like_params[:hypothesis_id], user_id: current_user.id)
    end
    count = like_type.where(hypothesis_id: like_params[:hypothesis_id]).count

    render json: { count: count  }, status: :ok
  end

  def destroy
    @likes = like_type.where(user_id: current_user.id, hypothesis_id: like_params[:hypothesis_id])
    count = @likes.count
    @likes.destroy_all
    render json: { count: count }, status: :ok
  end

  private

  def like_create_count
    create_count = 1
    hypothesis = Hypothesis.find(like_params[:hypothesis_id])
    hypothesis.tags.each do |tag|
      current_user.specialities.each do |speciality|
        if tag.name == speciality.category && create_count
          new_create_count = (speciality.rank || 1) * (ENV["RANK_MULTIPLIER"] || 5)
          create_count = new_create_count if new_create_count > create_count
        end
      end
    end
    create_count
  end

  def validate_liker
    render json: {}, status: :internal_server_error if current_user.id != params[:user_id].to_i
  end

  def liked?
    like_type.exists?(like_params.to_h)
  end

  def like_type
    params[:like_type].capitalize.constantize
  end

  def like_params
    params.permit(:like_type,:question_id, :user_id, :comment_id, :id, :lab_id, :hypothesis_id)
  end
end

