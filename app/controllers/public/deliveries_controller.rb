class Public::DeliveriesController < ApplicationController
  def index
    @deliveries = current_customer.deliveries.all
    @delivery_new = Delivery.new
  end

  def edit
  end
  
  def update
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
  
  private
    def delivery_params
      params.require(:delivery).permit(:postcode, :address, :name)
    end
end
