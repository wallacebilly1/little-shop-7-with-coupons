require "rails_helper"

RSpec.describe Coupon, type: :model do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @coupon1 = @merchant1.coupons.create!(name: "50% off", code: "Half Off", disc_int: 50, disc_type: 0, status: 0)
    @coupon2 = @merchant1.coupons.create!(name: "$5 off", code: "Take Five", disc_int: 5, disc_type: 1)
    @coupon3 = @merchant1.coupons.create!(name: "$10 off", code: "Take Ten", disc_int: 10, disc_type: 1)
    @coupon4 = @merchant2.coupons.create!(name: "10% off", code: "10-promo", disc_int: 10, disc_type: 0)

    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)

    @invoice1 = @coupon1.invoices.create!(customer_id: @customer1.id, status: 1)
    @invoice2 = @coupon1.invoices.create!(customer_id: @customer2.id, status: 1)
    @invoice3 = @coupon1.invoices.create!(customer_id: @customer3.id, status: 1)
    @invoice4 = @coupon2.invoices.create!(customer_id: @customer3.id, status: 1)
    @invoice5 = @coupon2.invoices.create!(customer_id: @customer3.id, status: 1)

    @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 0)
    @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: 0)
    @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: 0)
    @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: 0)
    @transaction5 = create(:transaction, invoice_id: @invoice5.id, result: 1)
  end

  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoices)}
    it { should have_many(:transactions)}
  end

  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :code}
    it { should validate_uniqueness_of :code}
    it { should validate_presence_of :disc_type}
    it { should validate_presence_of :disc_int}
    it { should validate_numericality_of :disc_int}
  end

  describe "instance methods" do
    describe ".formatted_disc" do
      it "combines the discount type and integer into a single printable value" do
        expect(@coupon1.formatted_disc).to eq "50%"
        expect(@coupon2.formatted_disc).to eq "$5"
      end
    end

    describe ".succesful_uses_count" do
      it "returns a count of how many successful transactions that a coupon has been used on" do
        expect(@coupon1.successful_uses_count).to eq 3
        expect(@coupon2.successful_uses_count).to eq 1
      end
    end

    describe ".pending_invoices?" do
      it "returns a boolean to describe if any invoices that the coupon is on have an 'in progress' status" do
        expect(@coupon1.pending_invoices?).to eq false

        @invoice1 = @coupon1.invoices.create!(customer_id: @customer1.id, status: 0)

        expect(@coupon1.pending_invoices?).to eq true
      end
    end
  end
end
