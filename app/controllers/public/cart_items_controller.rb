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
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path, notice: "deleted"
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "All deleted"
  end
  
  private
    def cart_item_params
      params.require(:cart_item).permit(:amount, :item_id)
    end
end
