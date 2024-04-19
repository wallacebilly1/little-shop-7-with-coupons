class Merchant::CouponsController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    coupon = Coupon.new(coupon_params)
    if coupon.save
      redirect_to merchant_coupons_path(@merchant)
    else
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:notice] = "Failed to Create Coupon"
    end
  end

  private
  def coupon_params
    params.permit(:name, :code, :disc_int, :disc_type, :merchant_id)
  end
end