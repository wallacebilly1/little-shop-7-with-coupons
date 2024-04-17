class Merchant::ItemsController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.new(item_params)
    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      redirect_to new_merchant_item_path(@merchant)
      flash[:notice] = "Failed to Create item :("
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if params[:status]
      item.update(status: params[:status])
      redirect_to merchant_items_path(merchant)
    elsif item.update(item_params)
      redirect_to merchant_item_path
      flash[:notice] = "Item successfully updated! :)"
    else
      redirect_to edit_merchant_item_path(merchant, item)      
    end
  end

  private
  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :status)
  end
end