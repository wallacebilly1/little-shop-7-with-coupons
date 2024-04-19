require 'rails_helper'

RSpec.describe "Merchant Coupons New" do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @coupon1 = @merchant1.coupons.create!(name: "50% off", code: "Half Off", disc_int: 50, disc_type: 0)
    @coupon2 = @merchant1.coupons.create!(name: "$5 off", code: "Take Five", disc_int: 5, disc_type: 1)
    @coupon3 = @merchant1.coupons.create!(name: "$10 off", code: "Take Ten", disc_int: 10, disc_type: 1)
    @coupon4 = @merchant2.coupons.create!(name: "10% off", code: "10-promo", disc_int: 10, disc_type: 0)
    
    visit new_merchant_coupon_path(@merchant1) 
  end

  describe '#Coupons User Story 2' do
    it "displays a form with fields for name, code, amount, and type of discount" do
      expect(find("form")).to have_content("Name:")
      expect(find("form")).to have_content("Code:")
      expect(find("form")).to have_content("Amount:")
      expect(find("form")).to have_content("Discount Type:")
    end

    it "when I fill out the form and click 'submit', I am redirected to the coupon index page where I see that coupon now listed" do
      fill_in :coupon_name, with: "$20 Off"
      fill_in :coupon_code, with: "Take 20"
      fill_in :coupon_disc_int, with: 20
      page.select '$', from: :coupon_disc_type
      click_on "Create Coupon"

      expect(current_path).to eq merchant_coupons_path(@merchant1)

      within "#coupon-#{Coupon.all.last.id}" do
        expect(page).to have_content("Name: $20 Off")
        expect(page).to have_content("Code: Take 20")
        expect(page).to have_content("Discount: $20")
      end
    end

    xit "gives an error message when trying to submit the form without all fields entered" do
      
    end
    
    xit "gives an error message when trying to create a coupon with a code that already exists in the database" do
      
    end

    xit "gives an error message when trying to create a coupon when 5 active coupons already exist for that merchant" do
      # likely save this test til I've built out the status functionality.
    end
  end
end