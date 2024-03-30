class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to questions_path, notice: "Successfully created Question"
    else
      flash.now[:alert] = "Something is wrong"
      render :new
    end
  end


  private

  def question_params
    params.require("question").permit(:heading, :text)
  end
end
