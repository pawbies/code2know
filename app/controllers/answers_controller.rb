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

  def edit
    
    @answer = Answer.find_by(id: params[:id])
    return unless require_user_or_admin @answer.user.id
    
  end

  def update
    @answer = Answer.find_by(id: params[:id])
    return unless require_user_or_admin @answer.user.id
    
    if @answer.update(answer_params)
      redirect_to origin_path(@answer), notice: "Updated question"
    else
      redirect_to origin_path(@answer), notice: "Could not update question"
    end
  end

  def set_helpful
    @answer = Answer.find_by(id: params[:id])
    
    if @answer.question.nil?
      creator = @answer.answer.user.id
    else
      creator = @answer.question.user.id
    end
    return unless require_user_or_admin creator    

    if @answer.update(helpful: params.require("answer")[:helpful])
      redirect_to origin_path(@answer), notice: "Successfully changed state"
    else
      redirect_to origin_path(@answer), notice: "Could not update state"
    end

  end

  private

  def answer_params
    params.require("answer").permit(:text)
  end

  def origin_path answer
    if answer.question.nil?
      answer_path(id: answer.answer.id)
    else
      question_path(id: answer.question.id)
    end
  end
  
end
