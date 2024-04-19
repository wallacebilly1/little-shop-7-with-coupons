require 'rails_helper'

RSpec.describe "Merchant Coupons Show" do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @coupon1 = @merchant1.coupons.create!(name: "50% Off", code: "Half Off", disc_int: 50, disc_type: 0, status: 0)
    @coupon2 = @merchant1.coupons.create!(name: "$5 Off", code: "Take Five", disc_int: 5, disc_type: 1)
    @coupon3 = @merchant1.coupons.create!(name: "$10 Off", code: "Take Ten", disc_int: 10, disc_type: 1)
    @coupon4 = @merchant2.coupons.create!(name: "10% Off", code: "10-promo", disc_int: 10, disc_type: 0)

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
    
    visit merchant_coupon_path(@merchant1, @coupon1) 
  end

  describe '#Coupons User Story 3' do
    it "displays the name, code, status, discount amount/type, and number of times that a coupon has been used" do
      expect(page).to have_content("Coupon Information")
      expect(page).to have_content("Name: 50% Off")
      expect(page).to have_content("Code: Half Off")
      expect(page).to have_content("Discount: 50%")
      expect(page).to have_content("Status: Active")
      expect(page).to have_content("Number of Uses: 3")
    end
  end
end
