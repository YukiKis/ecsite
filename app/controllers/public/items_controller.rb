class Public::ItemsController < ApplicationController
  def index
    @items = Item.active.all
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item_new = CartItem.new()
  end
  
  def categorized
    @items = Item.categorized(params[:category_id])
    render :index
  end
end