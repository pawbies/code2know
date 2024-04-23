class AnswersController < ApplicationController


  before_action :require_some_user
  
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
      if params[:type] == "question"
        redirect_to question_path(id: @answer.question.id), notice: "Created answer"
      elsif params[:type] == "answer"
        redirect_to answer_path(id: @answer.answer.id), notice: "Created answer"
      else
        redirect_to root_path, notice: "Something went wrong"
      end
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
