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
    coupon = @merchant.coupons.new(coupon_params)
    if coupon.save
      redirect_to merchant_coupons_path(@merchant)
    elsif [coupon_params[:name], coupon_params[:code], coupon_params[:disc_int], coupon_params[:disc_type]].any?(&:nil?) 
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:error] = "Please ensure all fields are complete"
    else
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:notice] = "Failed to Create Coupon"
    end
  end

  private
  def coupon_params
    params.require(:coupon)
          .permit(:name, :code, :disc_int, :disc_type, :merchant_id)
          .merge(disc_type: params[:coupon][:disc_type].to_i)
          .transform_values! { |v| v.presence || nil }
  end
end