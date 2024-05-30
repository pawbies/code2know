class QuestionsController < ApplicationController
  before_action :fetch_question_from_id, only: %i[show edit update destroy report]
  before_action :require_some_user, only: %i[new create report]
  before_action :require_creator, only: %i[edit update destroy]

  def index
    @questions = Question.all.order('questions.created_at DESC').limit(35)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = Current.user

    if @question.save
      Current.user.update(xp: Current.user.xp + 50)
      redirect_to questions_path, notice: 'Successfully created Question'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @answer = Answer.new
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to question_path(id: @question.id), notice: 'Question updated'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Deleted Question'
  end

  def report
    @question.reports.create(user: Current.user, message: params[:message])
    redirect_to question_path(@question), notice: "Thank you for your support"
  end

  private

  def require_creator
    require_user_or_admin @question.user.id
  end

  def fetch_question_from_id
    @question = Question.find_by(id: params[:id].to_i)
    redirect_to questions_path, notice: 'Question not found' if @question.nil?
  end

  def question_params
    params.require('question').permit(:heading, :text, :category_ids => [])
  end
end
