class HypothesesController < ApplicationController
  before_action :set_hypothesis, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:update, :create]

  def index
    @labs = Hypothesis.all.paginate(per_page: 10, page: params["page"])
    @tags = Tag.all
  end

  def show
    if @hypothesis
      @related_hypotheses = Hypothesis.where(parent: @hypothesis.id).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("hypotheses.*", "COUNT(upvotes.id) as upvote_count", "COUNT(downvotes.id) as downvote_count", "COUNT(likes.id) as like_count","COUNT(dislikes.id) as dislike_count" ,"users.name as fullname").group(:id, "fullname")
    end

    nested_ids = @related_hypotheses.map.collect{|hypothesis| hypothesis.id}.compact

    while(nested_ids.size != 0) do
      nested_hypotheses = Hypothesis.where(parent: nested_ids).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("hypotheses.*", "COUNT(upvotes.id) as upvote_count", "COUNT(downvotes.id) as downvote_count", "COUNT(likes.id) as like_count","COUNT(dislikes.id) as dislike_count","users.name as fullname").group(:id, "fullname").to_a
      nested_ids = nested_hypotheses.collect{|hypothesis| hypothesis.id}
      @related_hypotheses += nested_hypotheses
    end

    if (current_user)
      @related_hypotheses.each do |hypothesis|
        hypothesis.user_has_upvoted = !Upvote.where(hypothesis_id: hypothesis.id, user_id: current_user.id).empty? ? true : false
        hypothesis.user_has_downvoted = !Downvote.where(hypothesis_id: hypothesis.id, user_id: current_user.id).empty? ? true : false
        hypothesis.user_has_liked = !Like.where(hypothesis_id: hypothesis.id, user_id: current_user.id).empty? ? true : false
        hypothesis.user_has_disliked = !Dislike.where(hypothesis_id: hypothesis.id, user_id: current_user.id).empty? ? true : false
      end
    end

    respond_to do |format|
      format.html { render :show }
      format.json { render json:  { related_hypotheses: @related_hypotheses }.to_json(methods: [:user_has_upvoted, :user_has_downvoted, :user_has_liked, :user_has_disliked]) }
    end
  end

  def edit
  end

  def create
    if params[:hypothesis][:create_from]
      @hypothesis = Object.const_get(params[:hypothesis][:create_from]).find(params[:hypothesis][:create_from_id]).hypotheses.new(hypothesis_params)
    else 
      @hypothesis = current_user.hypotheses.new(hypothesis_params)
    end

    respond_to do |format|
      if @hypothesis.save
        @hypothesis = Hypothesis.where(id: @hypothesis.id).left_outer_joins(:upvotes, :downvotes, :user).select("hypotheses.*", "COUNT(upvotes.id) as upvote_count", "COUNT(downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname").first
        @hypothesis.user_has_upvoted = !Upvote.where(hypothesis_id: @hypothesis.id, user_id: current_user.id).empty? ? true : false
        @hypothesis.user_has_downvoted = !Downvote.where(hypothesis_id: @hypothesis.id, user_id: current_user.id).empty? ? true : false
        @hypothesis.user_has_liked = !Like.where(hypothesis_id: @hypothesis.id, user_id: current_user.id).empty? ? true : false
        @hypothesis.user_has_disliked = !Dislike.where(hypothesis_id: @hypothesis.id, user_id: current_user.id).empty? ? true : false
        format.html { redirect_to hypothesis_path(@hypothesis) }
        format.json { render json: { status: :created, hypothesis: @hypothesis }.to_json(methods: [:user_has_upvoted, :user_has_downvoted, :user_has_liked, :user_has_disliked]) } 
      else
        format.html { render :new }
        format.json { render json: @hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @hypothesis.update(hypothesis_params)
        format.html { redirect_to edit_hypothesis_path(@hypothesis.id), notice: 'hypothesis was successfully updated.' }
        format.json { render :show, status: :ok, location: @hypothesis }
      else
        format.html { render :edit }
        format.json { render json: @hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url, notice: 'hypothesis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_hypothesis
      if params[:id] == 0 || params[:id] == "0"
        @related_hypotheses = Hypothesis.where(hypothesis_params).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("hypotheses.*", "COUNT(likes.id) as like_count","COUNT(dislikes.id) as dislike_count","COUNT(upvotes.id) as upvote_count", "COUNT(downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname")
      else
        @hypothesis = Hypothesis.find(params[:id])
      end
    end

    def hypothesis_params
      params.require(:hypothesis).permit(:user_id, :lab_id, :hypothesis_id, :title, :body, :parent, comments_attributes: [:id, :title, :body])
    end
end


