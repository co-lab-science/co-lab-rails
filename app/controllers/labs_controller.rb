class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:update, :create]

  def index
    @labs = Lab.all.paginate(per_page: 10, page: params["page"])
    @tags = Tag.all
  end

  def show
    @questions = []
    @hypotheses =  []
    @related_observations = Lab.where(parent: @lab.id).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("labs.*", "COUNT(upvotes.id) as upvote_count", "COUNT(downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname")

    nested_ids = @related_observations.map.collect{|lab| lab.id}.compact

    while(nested_ids.size != 0) do
      nested_observations = Lab.where(parent: nested_ids).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("labs.*", "COUNT(upvotes.id) as upvote_count", "COUNT(downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname").to_a
      nested_ids = nested_observations.collect{|lab| lab.id}
      @related_observations += nested_observations
    end

    @related_observations.each do |observation|
      observation.user_has_upvoted = !Upvote.where(lab_id: observation.id, user_id: current_user.id).empty? ? true : false
      observation.user_has_downvoted = !Downvote.where(lab_id: observation.id, user_id: current_user.id).empty? ? true : false
    end

    respond_to do |format|
      format.html { render :show }
      format.json { render json:  { related_observations: @related_observations }.to_json(methods: [:user_has_upvoted, :user_has_downvoted]) }
    end
  end

  def new
    @lab = Lab.new
    @tags = Tag.all
  end

  def edit
  end

  def create
    @lab = current_user.labs.new(lab_params)
    respond_to do |format|
      if @lab.save
        @lab = Lab.where(id: @lab.id).left_outer_joins(:upvotes, :downvotes, :user).select("labs.*", "COUNT(upvotes.id) as upvote_count", "COUNT(downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname").first
        @lab.user_has_upvoted = !Upvote.where(lab_id: @lab.id, user_id: current_user.id).empty? ? true : false
        @lab.user_has_downvoted = !Downvote.where(lab_id: @lab.id, user_id: current_user.id).empty? ? true : false

        format.json { render json: { status: :created, observation: @lab } }
      else
        format.html { render :new }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lab.update(lab_params)
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { render :show, status: :ok, location: @lab }
      else
        format.html { render :edit }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lab.destroy
    respond_to do |format|
      format.html { redirect_to labs_url, notice: 'Lab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_lab
      @lab = Lab.find(params[:id])
    end

    def lab_params
      params.require(:lab).permit(:title, :body, :parent, comments_attributes: [:id, :title, :body])
    end
end

