class AdminController < ApplicationController
  def reports
    @reported_questions = Question.joins(:reports).distinct
  end
end
