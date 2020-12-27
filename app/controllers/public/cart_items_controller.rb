class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
  end
  
  def create
    @cart_item_new = current_customer.cart_items.new(cart_item_params)
    if @cart_item_new.save
      redirect_to cart_items_path, notice: "OK"
    else
      @item = Item.find(cart_item_params[:item_id])
      render "items/show"
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  def destroy_all
  end
  
  private
    def cart_item_params
      params.require(:cart_item).permit(:amount, :item_id)
    end
end
