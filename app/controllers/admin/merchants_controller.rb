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
    merchant = Merchant.find(params[:id])
    merchant.update!(admin_merchant_params)
    if params[:status]
      redirect_to admin_merchants_path
    elsif !params[:name].empty? 
      flash[:notice] = "Succefully Updated"
      redirect_to admin_merchant_path(merchant)
    else 
      flash[:alart] = "Error: All Fields Must Be Filled In"
      redirect_to edit_admin_merchant_path(merchant)
    end
  end

  def new 

  end

  def create 
    Merchant.create!(admin_merchant_params)
    redirect_to (admin_merchants_path)
  end


  private 

  def admin_merchant_params
    params.permit(:name, :status)
  end

end