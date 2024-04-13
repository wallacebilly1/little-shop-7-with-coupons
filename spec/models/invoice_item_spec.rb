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

  describe "instance methods" do
    it "#unit_price_in_dollars" do
      @cust1 = create(:customer)
      @inv1 = create(:invoice, customer_id: @cust1.id)
      @merch1 = create(:merchant)
      @it1 = create(:item, unit_price: 10000, merchant_id: @merch1.id)
      @it2 = create(:item, unit_price: 500, merchant_id: @merch1.id)
      @it3 = create(:item, unit_price: 7500, merchant_id: @merch1.id)
      @inv_it1 = @inv1.invoice_items.create!(item_id: @it1.id, quantity: 5, unit_price: @it1.unit_price, status: 0)
      @inv_it2 = @inv1.invoice_items.create!(item_id: @it2.id, quantity: 10, unit_price: @it2.unit_price, status: 0)

      expect(@inv_it1.unit_price_in_dollars).to eq 100.00
      expect(@inv_it2.unit_price_in_dollars).to eq 5.00
    end

    #   describe "#invoice_item_total_price" do
    #     it "returns the total price of invoice items" do
    #       invoice = create(:invoice)
    #       invoice_items = create_list(:invoice_item, 3, invoice: invoice, quantity: 2, unit_price: 10)
          
    #       total_price = invoice_items.invoice_item_total_price
          
    #       expect(invoice_item_total_price).to eq 60
    #     end
    #   end
  end
end
