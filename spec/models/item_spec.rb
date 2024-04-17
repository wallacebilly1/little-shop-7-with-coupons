require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices) }
    it { should have_many(:transactions) }
    it { should have_many(:customers) }
  end

  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price}
  end

  before(:each) do
    @customers = create_list(:customer, 10)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]
    @customer5 = @customers[4]
    @customer6 = @customers[5]


    @invoice1 = create(:invoice, customer: @customer1, created_at:  Time.utc(2004, 9, 13, 12, 0, 0) )
    @invoices = create_list(:invoice, 2, customer: @customer1)
    @invoice2 = @invoices[0]
    @invoice3 = @invoices[1]
    @invoice4 = create(:invoice, customer_id: @customer2.id, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
    @invoice5 = create(:invoice, customer_id: @customer3.id, created_at: Time.utc(2006, 1, 12, 1, 0, 0))
    @invoice6 = create(:invoice, customer_id: @customer4.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @invoice7 = create(:invoice, customer_id: @customer5.id, created_at: Time.utc(2024, 4, 6, 12, 0, 0))
    @invoice8 = create(:invoice, customer_id: @customer6.id, created_at: Time.utc(2024, 4, 7, 12, 0, 0))

    @invoice1_transactions = create_list(:transaction, 4, invoice: @invoice1)
    @invoice4_transactions = create_list(:transaction, 3, invoice: @invoice4)
    @invoice5_transactions = create_list(:transaction, 2, invoice: @invoice5)

    @transaction1 = @invoice1_transactions[0]
    @transaction2 = @invoice1_transactions[1]
    @transaction3 = @invoice1_transactions[2]
    @transaction4 = @invoice1_transactions[3]
    @transaction5 = @invoice4_transactions[0]
    @transaction6 = @invoice4_transactions[1]
    @transaction7 = @invoice4_transactions[2]
    @transaction8 = @invoice5_transactions[0]
    @transaction9 = @invoice5_transactions[1]
    @transaction10 = create(:transaction, invoice_id: @invoice2.id)
    @transaction11 = create(:transaction, invoice_id: @invoice3.id)
    @transaction12 = create(:transaction, invoice_id: @invoice6.id)
    @transaction13 = create(:transaction, invoice_id: @invoice7.id)

    @merchant1 = create(:merchant, name: "Amazon")

    @item1 = create(:item, unit_price: 1, merchant_id: @merchant1.id)
    @item2 = create(:item, unit_price: 23, merchant_id: @merchant1.id)
    @item3 = create(:item, unit_price: 100, merchant_id: @merchant1.id)
    @item4 = create(:item, unit_price: 5, merchant_id: @merchant1.id)
    @item5 = create(:item, unit_price: 12, merchant_id: @merchant1.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, status: 2)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id, status: 2)

    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item6 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1)
  end

  describe "class methods" do

  end

  describe "instance methods" do
    describe ".format_date" do
      it "formats date day, month, year" do
        expect(@item1.format_inv_date(@invoice4.id)).to eq("Monday, September 13, 2004")
      end
    end

    describe ".total_revenue" do
      it "returns the total revenue from all invoice items" do
        cust1 = create(:customer)
        inv1 = create(:invoice, customer_id: cust1.id)
        merch1 = create(:merchant)
        it1 = create(:item, unit_price: 10000, merchant_id: merch1.id)
        it2 = create(:item, unit_price: 500, merchant_id: merch1.id)
        it3 = create(:item, unit_price: 7500, merchant_id: merch1.id)
        inv_it1 = inv1.invoice_items.create!(item_id: it1.id, quantity: 5, unit_price: it1.unit_price, status: 0)
        inv_it2 = inv1.invoice_items.create!(item_id: it1.id, quantity: 10, unit_price: it2.unit_price, status: 0)
        inv_it3 = inv1.invoice_items.create!(item_id: it1.id, quantity: 1, unit_price: it3.unit_price, status: 0)

        expected_revenue = ((10000*5)+(500*10)+(7500*1))

        expect(it1.total_revenue).to eq(expected_revenue)
      end
    end

    describe ".order_date" do
      it "orders invoices by date from oldest to newest" do
        item1 = create(:item)
        invoice1 = create(:invoice, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
        invoice2 = create(:invoice, created_at: Time.utc(2004, 9, 14, 12, 0, 0))
        invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 10, unit_price: 10, status: 1)
        invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item1.id, quantity: 9, unit_price: 9, status: 1)

        expect(item1.order_date).to eq([invoice1, invoice2])
      end
    end
  end
end