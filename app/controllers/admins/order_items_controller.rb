class Admins::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:order_item_id])
    if @order_item.update(order_item_params)
      redirect_to admins_order_path(@order_item.order)
    end
  end
  
  private
    def order_item_params
      params.require(:order_item).permit(:status)
    end
end
