class Admins::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
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
    @item = Item.find(params[:id])
    categories = Category.active.all.map{ |c| [c.id, c.name] }
    @categories = {}
    categories.each do |c_id, c_name|
      @categories[c_name] = c_id
    end
  end
  
  def update
    @item = Item.find(params[:id])
    if item_params[:is_acitve] == "無効"
      item_params[:is_active] = false
    else
      item_params[:is_active] = true
    end
    if @item.update(item_params)
      redirect_to admins_item_path(@item), notice: "successfully update"
    else
      render :edit
    end
    debugger
  end
  
  private
    def item_params
      params.require(:item).permit(:image, :name, :description, :category_id, :price, :is_active)
    end
end
