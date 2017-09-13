class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:update, :create, :edit]

  def index
    @labs = Question.all.paginate(per_page: 10, page: params["page"])
    @tags = Tag.all.limit(10)
  end

  def show
    if @question
      @related_questions = Question.where(parent: @question.id).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("questions.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname")
    end

    nested_ids = @related_questions.map.collect{|question| question.id}.compact

    while(nested_ids.size != 0) do
      nested_questions = Question.where(parent: nested_ids).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("questions.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname").to_a
      nested_ids = nested_questions.collect{|question| question.id}
      @related_questions += nested_questions
    end

    if (current_user)
      @related_questions.each do |question|
        question.user_has_upvoted = !Upvote.where(question_id: question.id, user_id: current_user.id).empty? ? true : false
        question.user_has_downvoted = !Downvote.where(question_id: question.id, user_id: current_user.id).empty? ? true : false
      end
    end

    respond_to do |format|
      format.html { render :show }
      format.json { render json:  { related_questions: @related_questions }.to_json(methods: [:user_has_upvoted, :user_has_downvoted]) }
    end
  end

  def new
    @question = Question.new
    @tags = Tag.all.limit(10)
  end

  def edit
  end

  def create
    if params[:question][:create_from]
      @question = Object.const_get(params[:question][:create_from]).find(params[:question][:create_from_id]).questions.new(question_params)
    else
      @question = current_user.questions.new(question_params)
    end

    respond_to do |format|
      if @question.save
        if params[:tags]
          tag_names = params[:tags].split(/,/).collect{|tag| tag.strip}.uniq
          Tag.where(question_id: @question.id).destroy_all
          tag_names.each{ |tag_name| Tag.create(question_id: @question.id, name: tag_name) }
        end
        @question = Question.where(id: @question.id).left_outer_joins(:upvotes, :downvotes, :user).select("questions.*", "COUNT(upvotes.id) as upvote_count", "COUNT(downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname").first
        @question.user_has_upvoted = !Upvote.where(question_id: @question.id, user_id: current_user.id).empty? ? true : false
        @question.user_has_downvoted = !Downvote.where(question_id: @question.id, user_id: current_user.id).empty? ? true : false

        format.html { redirect_to question_path(@question) }
        format.json { render json: { status: :created, question: @question } }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        if params[:tags]
          tag_names = params[:tags].split(/,/).collect{|tag| tag.strip}.uniq
          Tag.where(question_id: @question.id).destroy_all
          tag_names.each{ |tag_name| Tag.create(question_id: @question.id, name: tag_name) }
        end
        format.html { redirect_to edit_question_path(@question.id), notice: 'question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      if params[:id] == 0 || params[:id] == "0"
        @related_questions = Question.where(question_params).left_outer_joins(:upvotes, :downvotes, :user, :likes, :dislikes).select("questions.*", "COUNT(DISTINCT upvotes.id) as upvote_count", "COUNT(DISTINCT downvotes.id) as downvote_count", "users.name as fullname").group(:id, "fullname")
      else
        @question = Question.find(params[:id])
      end
    end

    def question_params
      params.require(:question).permit(:user_id, :lab_id, :question_id, :title, :body, :parent, comments_attributes: [:id, :title, :body])
    end
end


