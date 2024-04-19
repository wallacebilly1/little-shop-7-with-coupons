require "rails_helper"

RSpec.describe Coupon, type: :model do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @coupon1 = @merchant1.coupons.create!(name: "50% off", code: "Half Off", disc_int: 50, disc_type: 0)
    @coupon2 = @merchant1.coupons.create!(name: "$5 off", code: "Take Five", disc_int: 5, disc_type: 1)
    @coupon3 = @merchant1.coupons.create!(name: "$10 off", code: "Take Ten", disc_int: 10, disc_type: 1)
    @coupon4 = @merchant2.coupons.create!(name: "10% off", code: "10-promo", disc_int: 10, disc_type: 0)
  end

  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoices)}
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
  end
end
