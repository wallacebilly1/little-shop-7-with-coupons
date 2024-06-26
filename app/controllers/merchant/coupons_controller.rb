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
      flash[:notice] = "Coupon succesfully created."
    elsif [coupon_params[:name], coupon_params[:code], coupon_params[:disc_int], coupon_params[:disc_type]].any?(&:nil?) 
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:error] = "Please ensure all fields are complete"
    elsif coupon.errors[:code].any?
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:notice] = "Please select a new coupon code, that one is already in use."
    end
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    coupon = Coupon.find(params[:id])
    if coupon.pending_invoices? && coupon.status == "active"
      redirect_to merchant_coupon_path(@merchant, coupon)
      flash[:error] = "Error: Cannot disable a coupon that is added to an in progress invoice"
    elsif @merchant.can_activate? == false && coupon.status == "inactive"
      redirect_to merchant_coupons_path(@merchant)
      flash[:error] = "Sorry, only 5 active coupons are allowed. Please deactivate one of the codes below if you would like to activate a new coupon."
    elsif coupon.update(status: params[:status])
      redirect_to merchant_coupon_path(@merchant, coupon)
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