class Admins::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admins_customer_path(@customer), notice: "successfully updated"
    else
      render :edit
    end
  end
  
  private
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :tel, :email, :is_active)
    end
end
