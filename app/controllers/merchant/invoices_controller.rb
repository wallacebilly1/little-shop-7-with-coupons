class Merchant::InvoicesController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.merchant_invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
  end
end