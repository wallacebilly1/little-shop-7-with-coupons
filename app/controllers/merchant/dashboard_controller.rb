class Merchant::DashboardController < ApplicationController 
  def index 
    #binding.pry
    @merchant = Merchant.find(params[:merchant_id])
  end
end