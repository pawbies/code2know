class AnswersController < ApplicationController

  def create

    if Current.user.nil?
      redirect_to new_session_path, notice: "Need to be logged in for that"
      return false
    end
    
    @answer = Answer.new(answer_params)
    @answer.user = Current.user
    
    if params[:source] == "question"
      @answer.question = Question.find_by(id: params[:id].to_i)
    elsif params[:source] == "answer"
      @answer.answer = Answer.find_by(id: params[:id])
    else
      redirect_to root_path, notice: "Invalid answer source"; return
    end

    if @answer.save

      Current.user.update(xp: Current.user.xp + 10)
      
      if params[:source] == "question"
        redirect_to question_path(id: @answer.question.id), notice: "Created answer"; return
      elsif params[:source] == "answer"
        redirect_to answer_path(id: @answer.answer.id), notice: "Created answer"; return
      else
        redirect_to question_path(id: @answer.question.id), alert: "Something went wrong"; return
      end
    else
      puts @answer.errors.full_messages
      puts @answer.helpful
      redirect_to users_path, alert: "Something went wrong"; return
    end
    
  end

  def show

    @answer = Answer.find_by(id: params[:id])
    @answer_new = Answer.new
    
  end

  def update
    @answer = Answer.find_by(id: params[:id])

    if @answer.question.nil?
      creator = @answer.answer.user.id
    else
      creator = @answer.question.user.id
    end

    return if require_user_or_admin creator
    

    @answer.update(answer_params)

    if @answer.question.nil?
      redirect_to answer_path(id: @answer.answer.id), notice: "Updated answer"
    else
      redirect_to question_path(id: @answer.question.id), notice: "Updated answer"
    end
  end


  private

  def answer_params
    params.require("answer").permit(:text, :helpful)
  end
  
end
