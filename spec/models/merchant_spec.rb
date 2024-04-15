require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices) }
    it { should have_many(:transactions) }
    it { should have_many(:customers) }
  end

  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
    @merchant6 = create(:merchant)
    @merchant7 = create(:merchant)
    @merchant8 = create(:merchant)

    @invoice1 = create(:invoice)
    @invoice2 = create(:invoice)
    @invoice3 = create(:invoice)
    @invoice4 = create(:invoice)
    @invoice5 = create(:invoice)
    @invoice6 = create(:invoice)
    @invoice7 = create(:invoice)
    @invoice8 = create(:invoice)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant2)
    @item3 = create(:item, merchant: @merchant3)
    @item4 = create(:item, merchant: @merchant4)
    @item5 = create(:item, merchant: @merchant5)
    @item6 = create(:item, merchant: @merchant6)
    @item7 = create(:item, merchant: @merchant7)
    @item8 = create(:item, merchant: @merchant7)

    create_list(:invoice_item, 5, unit_price: 1000, quantity: 5, invoice: @invoice1, item: @item1)
    create_list(:invoice_item, 2, unit_price: 2000, quantity: 2, invoice: @invoice2, item: @item2)
    create_list(:invoice_item, 1, unit_price: 5000, quantity: 2, invoice: @invoice3, item: @item3)
    create_list(:invoice_item, 1, unit_price: 2000, quantity: 4, invoice: @invoice4, item: @item4)
    create_list(:invoice_item, 4, unit_price: 4000, quantity: 5, invoice: @invoice5, item: @item5)
    create_list(:invoice_item, 3, unit_price: 10000, quantity: 10, invoice: @invoice6, item: @item6)
    create_list(:invoice_item, 2, unit_price: 9000, quantity: 1, invoice: @invoice7, item: @item7)
    create_list(:invoice_item, 5, unit_price: 9000, quantity: 1, invoice: @invoice8, item: @item8)

    create(:transaction, result: 1, invoice: @invoice1)
    create(:transaction, result: 1, invoice: @invoice2)
    create(:transaction, result: 0, invoice: @invoice3)
    create(:transaction, result: 1, invoice: @invoice4)
    create(:transaction, result: 1, invoice: @invoice5)
    create(:transaction, result: 1, invoice: @invoice6)
    create(:transaction, result: 1, invoice: @invoice7)
    create(:transaction, result: 1, invoice: @invoice8)
  end

  describe "class methods" do
    it '.top_five_merchants' do
      expect(Merchant.top_five_merchants).to match_array([@merchant6, @merchant5, @merchant7, @merchant1, @merchant2])
      
      expect(Merchant.top_five_merchants[0].total_revenue).to eq 300000
      expect(Merchant.top_five_merchants[1].total_revenue).to eq 80000
      expect(Merchant.top_five_merchants[2].total_revenue).to eq 63000
      expect(Merchant.top_five_merchants[3].total_revenue).to eq 25000
      expect(Merchant.top_five_merchants[4].total_revenue).to eq 8000
    end
  end

  describe "instance methods" do
    
  end
end