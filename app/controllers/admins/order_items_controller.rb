class Admins::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:order_item_id])
    if @order_item.update(status: order_item_params[:status].to_i)
      redirect_to admins_order_path(@order_item.order)
    end
    debugger
  end
  
  private
    def order_item_params
      params.require(:order_item).permit(:status)
    end
end
