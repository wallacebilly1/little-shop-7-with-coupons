require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  before(:each) do

  end

  describe "class methods" do

  end

  # describe "instance methods" do
  #   describe "#invoice_item_total_price" do
  #     it "returns the total price of invoice items" do
  #       invoice = create(:invoice)
  #       invoice_items = create_list(:invoice_item, 3, invoice: invoice, quantity: 2, unit_price: 10)
        
  #       total_price = invoice_items.invoice_item_total_price
        
  #       expect(invoice_item_total_price).to eq 60
  #     end
  #   end
  end
