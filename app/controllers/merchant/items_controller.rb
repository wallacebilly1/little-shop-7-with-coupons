class Merchant::ItemsController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
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
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])

    if item.update(item_params)
      redirect_to merchant_item_path
      flash[:notice] = "Item successfully updated! :)"
    else
      redirect_to edit_merchant_item_path(merchant, item)      
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end