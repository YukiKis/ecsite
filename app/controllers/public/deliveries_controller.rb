class Public::DeliveriesController < ApplicationController
  def index
    @deliveries = current_customer.deliveries.all
    @delivery_new = Delivery.new
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end
  
  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path, notice: "successfully update"
    else
      render :edit
    end
  end
  
  def create
    @delivery_new = current_customer.deliveries.new(delivery_params)
    if @delivery_new.save
      redirect_to deliveries_path, notice: "successfully made"
    else
      @deliveries = current_customer.deliveries.all
      render :index
    end
  end  
  
  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    redirect_to deliveries_path, notice: "successfully destroy"
  end
  
  private
    def delivery_params
      params.require(:delivery).permit(:postcode, :address, :name)
    end
end
