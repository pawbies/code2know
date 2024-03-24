class RanksController < ApplicationController

  before_action :require_admin
  
  def index
    @ranks = Rank.all
  end

  def new
    @rank = Rank.new
  end

  def create
    @rank = Rank.new(rank_params)

    if @rank.save
      redirect_to ranks_path
    else
      render :new
    end
  end


  private

  def rank_params

    params.require("rank").permit(:name, :level, :threshold)
    
  end
end
