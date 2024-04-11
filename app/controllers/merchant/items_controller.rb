class Merchant::ItemsController < ApplicationController 
  def index 
    @items = Item.all
  end
end