require "rails_helper"

RSpec.describe Coupon, type: :model do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Bill")
    @coupon1 = @merchant1.coupons.create!(name: "BOGO 50% OFF", code: "bogo50", disc_int: 50, disc_type: 0)
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
end
