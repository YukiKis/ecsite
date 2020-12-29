class Admins::ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item_new = Item.new
    categories = Category.active.all.map{ |c| [c.id, c.name] }
    @categories = {}
    categories.each do |c_id, c_name|
      @categories[c_name] = c_id
    end
  end
  
  def create
    @item_new = Item.new(item_params)
    debugger
    if @item_new.save
      redirect_to admins_item_path(@item_new), notice: "successfully made"
    else
      categories = Category.active.all.map{ |c| [c.id, c.name] }
      @categories = {}
      categories.each do |c_id, c_name|
        @categories[c_name] = c_id
      end      
      render :new
    end
  end
  
  def edit
  end
  
  private
    def item_params
      params.require(:item).permit(:image, :name, :description, :category_id, :price, :is_active)
    end
end
