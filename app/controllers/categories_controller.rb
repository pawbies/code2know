class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    return unless require_admin

    @category = Category.new
  end

  def create
    return unless require_admin
    
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by(id: params[:id])
  end

  def edit
    return unless require_admin
    
    @category = Category.find_by(id: params[:id])

    if not @category.present?
      redirect_to categories_path, notice: "Category does not exist"
    end
  end

  def update
    return unless require_admin
    
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
    return unless require_admin
    
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
