require 'rails_helper'

RSpec.describe "Merchant Coupons Index" do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @coupon1 = @merchant1.coupons.create!(name: "50% off", code: "Half Off", disc_int: 50, disc_type: 0)
    @coupon2 = @merchant1.coupons.create!(name: "$5 off", code: "Take Five", disc_int: 5, disc_type: 1)
    @coupon3 = @merchant1.coupons.create!(name: "$10 off", code: "Take Ten", disc_int: 10, disc_type: 1)
    @coupon4 = @merchant2.coupons.create!(name: "10% off", code: "10-promo", disc_int: 10, disc_type: 0)
    
    visit merchant_coupons_path(@merchant1) 
  end

  describe '#Coupons User Story 1' do
    it 'displays all coupon names for that merchant with the discount they provide' do
      within "#coupon-#{@coupon1.id}" do
        expect(page).to have_content("Name: 50% off")
        expect(page).to have_content("Code: Half Off")
        expect(page).to have_content("Discount: 50%")
      end

      within "#coupon-#{@coupon2.id}" do
        expect(page).to have_content("Name: $5 off")
        expect(page).to have_content("Code: Take Five")
        expect(page).to have_content("Discount: $5")
      end

      within "#coupon-#{@coupon3.id}" do
        expect(page).to have_content("Name: $10 off")
        expect(page).to have_content("Code: Take Ten")
        expect(page).to have_content("Discount: $10")
      end

      expect(page).to_not have_content("Name: 10% off")
      expect(page).to_not have_content("Code: 10-promo")
      expect(page).to_not have_content("Discount: 10%")
    end

    it "displays each coupons name as a link to that coupons show page" do
      expect(page).to have_link(@coupon1.name)
      expect(page).to have_link(@coupon2.name)
      expect(page).to have_link(@coupon3.name)

      click_on "#{@coupon1.name}"

      expect(current_path).to eq(merchant_coupon_path(@merchant1,@coupon1))
    end
  end

  describe "#Coupons User Story 2" do
    it "displays a link to create a new coupon that takes me to a coupon creation page" do
      expect(page).to have_link("Create a new coupon")

      click_on("Create a new coupon")

      expect(current_path).to eq(new_merchant_coupon_path(@merchant1))

      expect(find("form")).to have_content("Name:")
      expect(find("form")).to have_content("Code:")
      expect(find("form")).to have_content("Amount:")
      expect(find("form")).to have_content("Discount Type:")
    end
  end
end