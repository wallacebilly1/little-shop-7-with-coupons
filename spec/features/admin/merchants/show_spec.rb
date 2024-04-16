require "rails_helper"

RSpec.describe "Admin Merchants Show" do
  before(:each) do
    @merchant1 = Merchant.create(name: "Amazon")
    @merchant2 = Merchant.create(name: "Walmart")
    @merchant3 = Merchant.create(name: "Target")

    visit admin_merchant_path(@merchant1.id)
  end

  describe '#User Story 26' do
    it 'successfully updates the merchant' do
      expect(page).to have_link("Update #{@merchant1.name}")

      click_on("Update #{@merchant1.name}")

      expect(current_path).to eq(edit_admin_merchant_path(@merchant1.id))

      fill_in :name, with: "Dollar General"
      click_on "Submit"

      expect(current_path).to eq(admin_merchant_path(@merchant1.id))

      expect(page).to have_content("Successfully Updated")
      expect(page).to have_content("Dollar General")
    end

    it 'returns an error for incorrect updates' do 
      click_on("Update #{@merchant1.name}")

      fill_in :name, with: ""
      click_on "Submit"
      
      expect(current_path).to eq(edit_admin_merchant_path(@merchant1.id))
      expect(page).to have_content("Please enter a valid name")
    end
  end
end