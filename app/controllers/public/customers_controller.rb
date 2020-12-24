class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path, notice: "successfully updated"
    else
      render :edit
    end
  end
  
  def quit
  end
  
  def leave
    @customer = current_customer
    @customer.is_active = false
    @customer.save
    session.clear
    redirect_to root_path, notice: "退会しました"
  end
  
  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :tel, :email)
    end
end
