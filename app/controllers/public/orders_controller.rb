class Public::OrdersController < ApplicationController
  SHIPMENT = 800

  def show
  end

  def index
  end
  
  def new
  end
  
  def check
    @order_new = Order.new
    @payment = payment_check(info_params[:payment])
    
    delivery = 
    case info_params[:address]
    when "own_address"
      [current_customer.postcode, current_customer.address, current_customer.last_name + current_customer.first_name]
    when "registered_address"
      info_params[:registered_address].split(" ")
    when "new_address"
      [info_params[:new_address_postcode], info_params[:new_address_address], info_params[:new_address_name]]
    end
    @delivery_postcode = delivery[0]
    @delivery_address = delivery[1]
    @delivery_name = delivery[2]
    
    @shipment = SHIPMENT
    @subtotal = current_customer.subtotal_with_all_cart_items
    @total = @subtotal + @shipment
  end
  
  def create
    @order_new = current_customer.orders.new(order_params)
    @order_new.payment = payment_check(@order_new.payment)
    debugger
    if @order_new.save
      @order_new.set_order_items(current_customer)
      debugger
      if @order_new.save  
        redirect_to thanks_orders_path
      end
    else
    end
  end
  
  def thanks
  end
  
  private
    def info_params
      params.require(:info).permit(:payment, :address, :registered_address, :new_address_postcode, :new_address_address, :new_address_name)
    end
    
    def order_params
      params.require(:order).permit(:postcode, :address, :name, :payment)
    end
    
    def payment_check(payment)
      case payment
      when "0" then "クレジットカード"
      when "1" then "銀行振込"
      when "クレジットカード" then 0
      when "銀行振込" then 1
      end
    end
end
