class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order('questions.created_at DESC')
  end

  def new
    require_some_user
    @question = Question.new
  end

  def create
    require_some_user()

    @question = Question.new(question_params)
    @question.user = Current.user

    if @question.save
      Current.user.update(xp: Current.user.xp + 50)
      redirect_to questions_path, notice: 'Successfully created Question'
    else
      flash.now[:alert] = 'Something is wrong'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answer = Answer.new
  end

  def edit
    @question = Question.find_by(id: params[:id])
    if @question.nil?
      redirect_to questions_path, notice: 'Question not found'
    end

    require_user_or_admin @question.user.id

  end

  def update
    @question = Question.find_by(id: params[:id])
    if @question.nil?
      redirect_to questions_path, notice: 'Question not found'
    end

    require_user_or_admin @question.user.id

    if @question.update(question_params)
      redirect_to question_path(id: @question.id), notice: 'Question updated'
    else
      flash.now[:notice] = 'Something went wrong'
      render :edit
    end
  end

  def destory
    @question = Question.find_by(id: params[:id])
    if @question.nil?
      redirect_to questions_path, notice: 'Question not found'
    end

    require_user_or_admin @question.user.id

    @question.destroy

    redirect_to questions_path, notice: 'Deleted Question'
  end


  private

  def question_params
    params.require('question').permit(:heading, :text)
  end

end
