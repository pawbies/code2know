class CategoriesController < ApplicationController

  before_action :require_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find_by(id: params[:id])

    if not @category.present?
      redirect_to categories_path, notice: "Category does not exist"
    end
  end

  def update
    @category = Category.find_by(id: params[:id])

    if not @category.present?
      redirect_to categories_path, notice: "Category does not exist"
    end
    
    if @category.update(category_params)
      redirect_to categories_path, notice: "Updated"
    else
      render :edit
    end
  end

  def destroy
    category = Category.find_by(id: params[:id])
    if not category.present?
      redirect_to categories_path, notice: "categorie does not exit"
    end

    category.destroy

    redirect_to categories_path, notice: "categorie deleted"
  end

  private

  def category_params
    params.require("category").permit(:name)
  end

  
end
