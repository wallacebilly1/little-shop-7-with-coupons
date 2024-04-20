require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:coupons) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices) }
    it { should have_many(:transactions) }
    it { should have_many(:customers) }
  end

  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant, name: "Amazon")

    @customers = create_list(:customer, 10)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]
    @customer5 = @customers[4]
    @customer6 = @customers[5]

    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice1 = @invoices[0]
    @invoice2 = @invoices[1]
    @invoice3 = @invoices[2]
    @invoice4 = create(:invoice, customer_id: @customer2.id, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
    @invoice5 = create(:invoice, customer_id: @customer3.id, created_at: Time.utc(2006, 1, 12, 1, 0, 0))
    @invoice6 = create(:invoice, customer_id: @customer4.id)
    @invoice7 = create(:invoice, customer_id: @customer5.id)
    @invoice8 = create(:invoice, customer_id: @customer6.id)

    @invoice1_transactions = create_list(:transaction, 5, invoice: @invoice1)
    @transaction1 = @invoice1_transactions[0]
    @transaction2 = @invoice1_transactions[1]
    @transaction3 = @invoice1_transactions[2]
    @transaction4 = @invoice1_transactions[3]
    @transaction5 = @invoice1_transactions[4]

    @invoice4_transactions = create_list(:transaction, 4, invoice: @invoice4)
    @transaction6 = @invoice4_transactions[0]
    @transaction7 = @invoice4_transactions[1]
    @transaction8 = @invoice4_transactions[2]
    @transaction9 = @invoice4_transactions[3]

    @invoice5_transactions = create_list(:transaction, 3, invoice: @invoice5)
    @transaction10 = @invoice5_transactions[0]
    @transaction11 = @invoice5_transactions[1]
    @transaction12 = @invoice4_transactions[2]

    @invoice6_transactions = create_list(:transaction, 2, invoice: @invoice6)
    @transaction13 = @invoice6_transactions[0]
    @transaction14 = @invoice6_transactions[1]

    @invoice7_transactions = create_list(:transaction, 1, invoice: @invoice7)
    @transaction15 = @invoice7_transactions[0]
   
    @transaction16 = create(:transaction, invoice_id: @invoice2.id)
    @transaction17 = create(:transaction, invoice_id: @invoice3.id)
    @transaction18 = create(:transaction, invoice_id: @invoice6.id)
    @transaction19 = create(:transaction, invoice_id: @invoice7.id)

    @item1 = create(:item, unit_price: 1, merchant_id: @merchant1.id)
    @item2 = create(:item, unit_price: 23, merchant_id: @merchant1.id)
    @item3 = create(:item, unit_price: 100, merchant_id: @merchant1.id)
    @item4 = create(:item, unit_price: 5, merchant_id: @merchant1.id)
    @item5 = create(:item, unit_price: 12, merchant_id: @merchant1.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0, unit_price: 10, quantity: 10)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, status: 2, unit_price: 11, quantity: 10)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id, status: 2, unit_price: 12, quantity: 10)
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, status: 1, unit_price: 13, quantity: 10)
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1, unit_price: 14, quantity: 10)
    @invoice_item6 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1, unit_price: 15, quantity: 10)
    @invoice_item7 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, status: 1, unit_price: 16, quantity: 10)
    @invoice_item8 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, status: 2, unit_price: 17, quantity: 10)
    @invoice_item9 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice6.id, status: 2, unit_price: 18, quantity: 10)
    @invoice_item10 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice7.id, status: 2, unit_price: 19, quantity: 10)
  end

  describe "class methods" do
    describe '#top_five_merchants' do
      it "returns the top five merchants based on total revenue" do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
        merchant3 = create(:merchant)
        merchant4 = create(:merchant)
        merchant5 = create(:merchant)
        merchant6 = create(:merchant)
        merchant7 = create(:merchant)
        merchant8 = create(:merchant)

        invoice1 = create(:invoice)
        invoice2 = create(:invoice)
        invoice3 = create(:invoice)
        invoice4 = create(:invoice)
        invoice5 = create(:invoice)
        invoice6 = create(:invoice)
        invoice7 = create(:invoice)
        invoice8 = create(:invoice)

        item1 = create(:item, merchant:  merchant1)
        item2 = create(:item, merchant:  merchant2)
        item3 = create(:item, merchant:  merchant3)
        item4 = create(:item, merchant:  merchant4)
        item5 = create(:item, merchant:  merchant5)
        item6 = create(:item, merchant:  merchant6)
        item7 = create(:item, merchant:  merchant7)
        item8 = create(:item, merchant:  merchant7)

        create_list(:invoice_item, 5, unit_price: 1000, quantity: 5, invoice:  invoice1, item:  item1)
        create_list(:invoice_item, 2, unit_price: 2000, quantity: 2, invoice:  invoice2, item:  item2)
        create_list(:invoice_item, 1, unit_price: 5000, quantity: 2, invoice:  invoice3, item:  item3)
        create_list(:invoice_item, 1, unit_price: 2000, quantity: 4, invoice:  invoice4, item:  item4)
        create_list(:invoice_item, 4, unit_price: 4000, quantity: 5, invoice:  invoice5, item:  item5)
        create_list(:invoice_item, 3, unit_price: 10000, quantity: 10, invoice:  invoice6, item:  item6)
        create_list(:invoice_item, 2, unit_price: 9000, quantity: 1, invoice:  invoice7, item:  item7)
        create_list(:invoice_item, 5, unit_price: 9000, quantity: 1, invoice:  invoice8, item:  item8)

        create(:transaction, result: 1, invoice: invoice1)
        create(:transaction, result: 1, invoice: invoice2)
        create(:transaction, result: 0, invoice: invoice3)
        create(:transaction, result: 1, invoice: invoice4)
        create(:transaction, result: 1, invoice: invoice5)
        create(:transaction, result: 1, invoice: invoice6)
        create(:transaction, result: 1, invoice: invoice7)
        create(:transaction, result: 1, invoice: invoice8)
      
        expect(Merchant.top_five_merchants).to match_array([ merchant6, merchant5,  merchant7, merchant1,  merchant2])
        
        expect(Merchant.top_five_merchants[0].total_revenue).to eq 300000
        expect(Merchant.top_five_merchants[1].total_revenue).to eq 80000
        expect(Merchant.top_five_merchants[2].total_revenue).to eq 63000
        expect(Merchant.top_five_merchants[3].total_revenue).to eq 25000
        expect(Merchant.top_five_merchants[4].total_revenue).to eq 8000
      end
    end
  end

  describe "instance methods" do
    describe ".top_five_items" do
      it "sorts items into top five" do
        expect(@merchant1.top_five_items).to eq([@item5, @item2, @item4, @item1, @item3])
      end
    end
  
    describe ".top_5_customers" do
      it "Returns the Top 5 Customers" do
        expect(@merchant1.top_5_customers).to match_array([@customer1, @customer2, @customer3, @customer4, @customer5])
      end
    end

    describe ".packaged_items" do
      it "list merchants packaged items" do
        expected = [@item4, @item5]

        expect(@merchant1.packaged_items.uniq).to eq(expected)
      end
    end

    describe "#can_activate?" do
      it "returns a boolean for whether a coupon can be activated (aka if 5 active coupons already exist for that merchant)" do
        @merchant3 = create(:merchant)
        @coup1 = create(:coupon, merchant: @merchant3, status: 0)
        @coup2 = create(:coupon, merchant: @merchant3, status: 0)
        @coup3 = create(:coupon, merchant: @merchant3, status: 0)
        @coup4 = create(:coupon, merchant: @merchant3, status: 0)

        expect(@merchant3.can_activate?).to eq true

        @coup5 = create(:coupon, merchant: @merchant3, status: 0)

        expect(@merchant3.can_activate?).to eq false
      end
    end
  end
end