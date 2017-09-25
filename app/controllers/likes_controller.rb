class LikesController < ApplicationController
  before_action :validate_liker

  def create
    like_create_count.times do
      like_type.create(hypothesis_id: like_params[:hypothesis_id], user_id: current_user.id)
    end

    render json: { count: like_create_count  }, status: :ok
  end

  def destroy
    @likes = like_type.where(user_id: current_user.id, hypothesis_id: like_params[:hypothesis_id])
    count = @likes.count
    @likes.destroy_all

    Hypothesis.find_by(id: like_params[:hypothesis_id]).reviews.where(user_id: current_user.id).destroy_all
    render json: { count: count }, status: :ok
  end

  private

  def like_create_count
    create_count = 1
    hypothesis = Hypothesis.find(like_params[:hypothesis_id])
    scores = []
    hypothesis.tags.each do |tag|
      current_user.specialities.each do |speciality|
        if tag.name == speciality.category
          score = (speciality.rank || 1) * (ENV["RANK_MULTIPLIER"].try(:to_i) || 5)
          scores << score
        end
      end
    end

    if !scores.empty?
      average = scores.inject{ |sum, el| sum + el }.to_f / scores.size
      create_count = average.floor
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

