require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items) }
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
  end

  describe "class methods" do

  end

  describe "instance methods" do
    it ".name" do
      expect(@customer1.name).to eq("#{@customer1.first_name} #{@customer1.last_name}")
      expect(@customer2.name).to eq("#{@customer2.first_name} #{@customer2.last_name}")
    end
  end
end