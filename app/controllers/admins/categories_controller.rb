class Admins::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category_new = Category.new
  end

  def create
    @category_new = Category.new(category_params)
    if @category_new.save
      redirect_to admins_categories_path, notice: "successfully made"
    else
      @categories = Category.all
      render :index
    end
  end
      

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admins_categories_path, notice: "successfully updated" 
    else
      render :edit
    end
  end
  
  private
    def category_params
      params.require(:category).permit(:name, :is_active)
    end
end
