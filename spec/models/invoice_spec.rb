require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items) }
    it { should have_many(:merchants) }
  end

  before(:each) do
    @customers = create_list(:customer, 4)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]

    @invoice1 = create(:invoice, customer: @customer1, created_at: "2004-13-09")
  end

  describe "class methods" do

  end

  describe "instance methods" do
    describe ".format_date" do
      it "formats date day, month, year" do
        expect(@invoice1.format_date).to eq("Monday, September 13, 2004")
      end
    end
  end
end