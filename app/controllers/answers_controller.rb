class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    @answer.user = Current.user

    if params[:type] == "question"
      @answer.question = Question.find_by(id: params[:id].to_i)
    elsif params[:type] == "answer"
      @answer.answer = Answer.find_by(id: params[:id])
    else
      redirect_to root_path, notice: "Invalid"
    end

    if @answer.save
      redirect_to root_path
    else
      redirect_to users_path
    end
    
  end

  def show

    @answer = Answer.find_by(id: params[:id])
    @answer_new = Answer.new
    
  end


  private

  def answer_params
    params.require("answer").permit(:text)
  end
  
end
