class Merchant::InvoicesController < ApplicationController 
  def index 
    @invoices = Invoice.all
  end
end