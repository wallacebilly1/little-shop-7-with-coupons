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
    # require 'pry'; binding.pry
    merchant.update(params[:name])
    redirect_to admin_merchant_path(merchant.id)
  end

end