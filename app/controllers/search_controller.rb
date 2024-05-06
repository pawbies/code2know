class SearchController < ApplicationController
  def new; end

  def show
    @query = params[:query]

    lower = @query.downcase

    @users = User.where('LOWER(username) LIKE ?', "%#{lower}%")
    @questions = Question.where('LOWER(heading) LIKE ?', "%#{lower}%")
  end
end
