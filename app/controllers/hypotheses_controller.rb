class HypothesesController < ApplicationController
  before_action :set_hypothesis, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:update, :create, :edit]

  def index
    @labs = Hypothesis.all.paginate(per_page: 10, page: params["page"])
    @tags = Tag.all
  end


  def new
    @hypothesis = Hypothesis.new
    @tags = Tag.all.limit(10)
  end

  def show
    if @hypothesis
      @related_hypotheses = Hypothesis.where(parent: @hypothesis.id).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("hypotheses.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT (DISTINCT downvotes.id) as downvote_count", "COUNT(DISTINCT likes.id) as like_count","COUNT(DISTINCT dislikes.id) as dislike_count" ,"users.name as fullname", "users.id as user_id").group(:id, "upvotes.id", "users.id","fullname")
    end

    nested_ids = @related_hypotheses.map.collect{|hypothesis| hypothesis.id}.compact

    while(nested_ids.size != 0) do
      nested_hypotheses = Hypothesis.where(parent: nested_ids).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("hypotheses.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "COUNT(DISTINCT likes.id) as like_count","COUNT(DISTINCT dislikes.id) as dislike_count","users.name as fullname", "users.id as user_id").group(:id, "users.id","fullname").to_a
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
    if params[:hypothesis][:create_from].present?
      parent = hypothesis_params[:parent].present? ? hypothesis_params[:parent] : params[:hypothesis][:create_from_id]
      if params[:hypothesis][:create_from] == "Hypothesis"
        @hypothesis = Object.const_get(params[:hypothesis][:create_from]).new(hypothesis_params.merge(user_id: current_user.id, parent: parent))
      else
        @hypothesis = Object.const_get(params[:hypothesis][:create_from]).find(params[:hypothesis][:create_from_id]).hypotheses.new(hypothesis_params.merge(user_id: current_user.id))
      end
      group_id = Lab.find(@hypothesis.lab_id).group_id
      @hypothesis.group_id = group_id
    else
      @hypothesis = current_user.hypotheses.new(hypothesis_params)
    end

    respond_to do |format|
      if @hypothesis.save
        if params[:tags]
          tag_names = params[:tags].split(/,/).collect{|tag| tag.strip}.uniq
          Tag.where(hypothesis_id: @hypothesis.id).destroy_all
          tag_names.each{ |tag_name| Tag.create(hypothesis_id: @hypothesis.id, name: tag_name) }
        end
        @hypothesis = Hypothesis.where(id: @hypothesis.id).left_outer_joins(:upvotes, :downvotes, :user).select("hypotheses.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT( DISTINCT downvotes.id) as downvote_count", "users.name as fullname", "users.id as user_id").group(:id, "users.id","fullname").first
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
        if params[:tags]
          tag_names = params[:tags].split(/,/).collect{|tag| tag.strip}.uniq
          Tag.where(hypothesis_id: @hypothesis.id).destroy_all
          tag_names.each{ |tag_name| Tag.create(hypothesis_id: @hypothesis.id, name: tag_name) }
        end
        format.html { redirect_to hypothesis_path(@hypothesis.id), notice: 'Hypothesis was successfully updated.' }
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
        @related_hypotheses = Hypothesis.where(hypothesis_params).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("hypotheses.*", "COUNT(DISTINCT likes.id) as like_count","COUNT(DISTINCT dislikes.id) as dislike_count","COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname", "users.id as user_id").group(:id, "users.id","fullname")
      else
        @hypothesis = Hypothesis.find(params[:id])
      end
    end

    def hypothesis_params
      params.require(:hypothesis).permit(:question_id, :user_id, :lab_id, :hypothesis_id, :group, :group_id, :title, :body, :parent, comments_attributes: [:id, :title, :body])
    end
end
