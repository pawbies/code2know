class AnswersController < ApplicationController
  before_action :fetch_answer, only: %i[show edit update set_helpful destroy]
  before_action :require_some_user, only: %i[create]
  before_action :require_creator, only: %i[edit update]
  before_action :require_poster, only: %i[set_helpful]
  before_action :require_creator_or_poster, only: %i[destroy]

  def create
    @answer = Answer.new(answer_params)
    @answer.user = Current.user
    set_answer_source

    if @answer.save
      Current.user.update(xp: Current.user.xp + 10)
      answer_redirect
    else
      redirect_to users_path, alert: 'Something went wrong'
    end
  end

  def show
    @answer_new = Answer.new
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to origin_path(@answer), notice: 'Updated question'
    else
      redirect_to origin_path(@answer), notice: 'Could not update question'
    end
  end

  def destroy
    @answer.destroy
    redirect_to questions_path, notice: 'Deleted answer'
  end

  def set_helpful
    if @answer.update(helpful: params.require('answer')[:helpful])
      redirect_to origin_path(@answer), notice: 'Successfully changed state'
    else
      redirect_to origin_path(@answer), notice: 'Could not update state'
    end
  end

  private

  def require_creator_or_poster
    poster = @answer.question.nil? ? @answer.answer.user.id : @answer.question.user.id
    creator = @answer.user.id

    require_admin_or_one_of [poster, creator]
  end

  def require_poster
    poster = @answer.question.nil? ? @answer.answer.user.id : @answer.question.user.id
    require_user_or_admin poster
  end

  def require_creator
    require_user_or_admin @answer.user.id
  end

  def fetch_answer
    @answer = Answer.find_by(id: params[:id])
  end

  def answer_params
    puts params
    params.require('answer').permit(:text)
  end

  def origin_path(answer)
    if answer.question.nil?
      answer_path(id: answer.answer.id)
    else
      question_path(id: answer.question.id)
    end
  end

  def set_answer_source
    if params[:source] == 'question'
      @answer.question = Question.find_by(id: params[:id])
    elsif params[:source] == 'answer'
      @answer.answer = Answer.find_by(id: params[:id])
    else
      redirect_to question_path(id: @answer.question.id), alert: 'Something went wrong with the source'
    end
  end

  def answer_redirect
    if params[:source] == 'question'
      redirect_to question_path(id: @answer.question.id), notice: 'Created answer'
    elsif params[:source] == 'answer'
      redirect_to answer_path(id: @answer.answer.id), notice: 'Created answer'
    else
      redirect_to question_path(id: @answer.question.id), alert: 'Something went wrong with the red'
    end
  end
end
