class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    require_some_user()
    @question = Question.new
  end

  def create

    require_some_user()
    
    @question = Question.new(question_params)
    @question.user = Current.user

    if @question.save
      redirect_to questions_path, notice: "Successfully created Question"
    else
      flash.now[:alert] = "Something is wrong"
      render :new
    end
  end

  def show
    @question = Question.find_by(id: params[:id])
  end

  private

  def question_params
    params.require("question").permit(:heading, :text)
  end
end
