class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:update, :create, :edit]

  def index
    @labs = Lab.all.paginate(per_page: 10, page: params["page"])
    @tags = Tag.all.limit(10)
  end

  def show
    if @lab
      @related_observations = Lab.where(parent: @lab.id).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("labs.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname", "users.id as user_id").group(:id, "users.id" ,"fullname")
    end

      nested_ids = @related_observations.map.collect{|lab| lab.id}.compact

      while(nested_ids.size != 0) do
        nested_observations = Lab.where(parent: nested_ids).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("labs.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname", "users.id as user_id").group(:id, "users.id", "fullname").to_a
        nested_ids = nested_observations.collect{|lab| lab.id}
        @related_observations += nested_observations
      end

      if (current_user)
        @related_observations.each do |observation|
          observation.user_has_upvoted = !Upvote.where(lab_id: observation.id, user_id: current_user.id).empty? ? true : false
          observation.user_has_downvoted = !Downvote.where(lab_id: observation.id, user_id: current_user.id).empty? ? true : false
        end
      end

    respond_to do |format|
      format.html { render :show }
      format.json { render json:  { related_observations: @related_observations }.to_json(methods: [:user_has_upvoted, :user_has_downvoted]) }
    end
  end

  def new
    if params[:p].nil?
      @lab = Lab.new
      @tags = Tag.all.limit(10)
    else
      if params[:ptype] == "Lab"
        @parent = Lab.find(params[:p])
      elsif params[:ptype] == "Question"
        @parent = Question.find(params[:p])
      elsif params[:ptype] == "Hypothesis"
        @parent = Hypothesis.find(params[:p])
      end
      @lab = Lab.new
      @tags = Tag.all.limit(10)
      @parent
    end
  end

  def edit
  end

  def create
    if params[:lab][:create_from].present?
      parent = lab_params[:parent].present? ? lab_params[:parent] : params[:lab][:create_from_id]
      if params[:lab][:create_from] == "Lab"
        @lab = Object.const_get(params[:lab][:create_from]).new(lab_params.merge(user_id: current_user.id, parent: parent))
      else
        @lab = Object.const_get(params[:lab][:create_from].capitalize).find(params[:lab][:create_from_id]).labs.new(lab_params.merge(user_id: current_user.id))
      end
    else
      @lab = current_user.labs.new(lab_params)
    end
    group_id = 1
    unless @lab.lab_id.nil?
      group_id = Lab.find(@lab.parent).group_id
    end
    @lab.group_id = group_id
    @lab.save

    respond_to do |format|
      if @lab.save
        if params[:tags]
          tag_names = params[:tags].split(/,/).collect{|tag| tag.strip}.uniq
          Tag.where(lab_id: @lab.id).destroy_all
          tag_names.each{ |tag_name| Tag.create(lab_id: @lab.id, name: tag_name) }
        end


        @lab = Lab.where(id: @lab.id).left_outer_joins(:upvotes, :downvotes, :user).select("labs.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname", "users.id as user_id").group(:id, "users.id", "fullname").first
        @lab.user_has_upvoted = !Upvote.where(lab_id: @lab.id, user_id: current_user.id).empty? ? true : false
        @lab.user_has_downvoted = !Downvote.where(lab_id: @lab.id, user_id: current_user.id).empty? ? true : false

        format.html { redirect_to observation_path(@lab) }
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
        if params[:tags]
          tag_names = params[:tags].split(/,/).collect{|tag| tag.strip}.uniq
          Tag.where(lab_id: @lab.id).destroy_all
          tag_names.each{ |tag_name| Tag.create(lab_id: @lab.id, name: tag_name) }
        end
        format.html { redirect_to observation_path(@lab.id), notice: 'Observation was successfully updated.' }
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
    if params[:id] == 0 || params[:id] == "0"
      @related_observations = Lab.where(lab_params).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("labs.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname", "users.id as user_id").group(:id, "users.id", "fullname")
    else
      @lab = Lab.find(params[:id])
    end
  end

  def lab_params
    params.require(:lab).permit(:hypothesis_id, :user_id, :lab_id, :group, :group_id, :question_id, :title, :body, :parent, comments_attributes: [:id, :title, :body])
  end
end
