require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions) }
    it { should have_many(:merchants) }
  end

  before(:each) do
    @customers = create_list(:customer, 10)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]
    @customer5 = @customers[4]
    @customer6 = @customers[5]

    @invoice_list1 = create_list(:invoice, 3, customer: @customer1)
    @invoice1 = @invoice_list1[0]
    @invoice2 = @invoice_list1[1]
    @invoice3 = @invoice_list1[2]
    @invoice_list2 = create_list(:invoice, 3, customer: @customer2)
    @invoice4 = @invoice_list2[0]
    @invoice5 = @invoice_list2[1]
    @invoice6 = @invoice_list2[2]
    @invoice7 = create(:invoice, customer_id: @customer3.id)
    @invoice8 = create(:invoice, customer_id: @customer3.id)
    @invoice9 = create(:invoice, customer_id: @customer4.id)
    @invoice10 = create(:invoice, customer_id: @customer4.id)
    @invoice11 = create(:invoice, customer_id: @customer5.id)
    @invoice12 = create(:invoice, customer_id: @customer5.id)
    @invoice13 = create(:invoice, customer_id: @customer6.id)
    @invoice14 = create(:invoice, customer_id: @customer6.id)
    @invoice15 = create(:invoice, customer_id: @customer1.id)

    #1 - 4trans; 2 - 3trans, 3 - 1, 4 - 2, 5 - 2, 6 -2
    create(:transaction, invoice_id: @invoice1.id, result: 0)
    create(:transaction, invoice_id: @invoice2.id, result: 0)
    create(:transaction, invoice_id: @invoice3.id, result: 0)
    create(:transaction, invoice_id: @invoice4.id, result: 0)
    create(:transaction, invoice_id: @invoice5.id, result: 0)
    create(:transaction, invoice_id: @invoice6.id, result: 0)
    create(:transaction, invoice_id: @invoice7.id, result: 0)
    create(:transaction, invoice_id: @invoice8.id, result: 1)
    create(:transaction, invoice_id: @invoice9.id, result: 0)
    create(:transaction, invoice_id: @invoice10.id, result: 0)
    create(:transaction, invoice_id: @invoice11.id, result: 0)
    create(:transaction, invoice_id: @invoice12.id, result: 0)
    create(:transaction, invoice_id: @invoice13.id, result: 0)
    create(:transaction, invoice_id: @invoice14.id, result: 0)
    create(:transaction, invoice_id: @invoice15.id, result: 0)
  end

  describe "class methods" do
    describe "#top_customers" do
      it "displays the top 5 customers in terms of successful transactions" do
        top_customers = Customer.top_customers

        expect(top_customers).to eq([@customer1, @customer2, @customer4, @customer5, @customer6])
        
        expect(@customer1.transactions.count).to eq 4
        expect(@customer2.transactions.count).to eq 3
        expect(@customer4.transactions.count).to eq 2
        expect(@customer5.transactions.count).to eq 2
        expect(@customer6.transactions.count).to eq 2
      end
    end
  end

  describe "instance methods" do
    describe ".name" do
      it "combines first and last names" do
        expect(@customer1.name).to eq("#{@customer1.first_name} #{@customer1.last_name}")
        expect(@customer2.name).to eq("#{@customer2.first_name} #{@customer2.last_name}")
      end
    end
  end
end