class Admin::DashboardController < ApplicationController 

  def index 
    @customers = Customer.all
    @top_5_customers = Customer.top_customers
  end
end