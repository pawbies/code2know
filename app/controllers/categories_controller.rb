class CategoriesController < ApplicationController
  before_action :require_admin, only: %i[new create edit update destroy]
  before_action :fetch_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Updated successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Updated'
    else
      render :edit
    end
  end

  def destroy
    category.destroy
    redirect_to categories_path, notice: 'categorie deleted'
  end

  private

  def fetch_category
    @category = Category.find_by(id: params[:id])
    redirect_to categories_path, notice: 'categorie does not exit' if @category.nil?
  end

  def category_params
    params.require('category').permit(:name)
  end
end
