class Admin::MerchantsController < ApplicationController
  def index 
    @merchants = Merchant.all
    @top5 = Merchant.top_five_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(admin_merchant_params)
      if params[:status]
        redirect_to admin_merchants_path
      else params[:name]
        redirect_to admin_merchant_path(@merchant)
      end
      flash[:notice] = "Successfully Updated"
    else
      redirect_to edit_admin_merchant_path(@merchant)
      flash[:alert] = "Please enter a valid name"
    end
  end

  def create
    Merchant.create(admin_merchant_params)
    redirect_to (admin_merchants_path)
  end

  private
  def admin_merchant_params
    params.permit(:name, :status)
  end
end