class Admin::MerchantsController < ApplicationController

  def index 
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def edit 
    @merchant = Merchant.find(params[:id])
  end
  
  def update 
    # require 'pry'; binding.pry
    merchant = Merchant.find(params[:id])
    # require 'pry'; binding.pry
    if merchant.update(admin_merchant_params)
      flash[:notice] = "Succesfully Updated"
      redirect_to admin_merchant_path(merchant.id)
      # merchant.save
    else 
      flash[:alert] = "Error: All Fields Must Be Filled In"
    end
  end


  private 

  def admin_merchant_params
    params.permit(:name)
  end

end