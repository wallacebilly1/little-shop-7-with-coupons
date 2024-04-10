require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant1 = create(:merchant, id: 1)

    @customers = create_list(:customer, 10)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]

    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice1 = @invoices[0]
    @invoice2 = @invoices[1]
    @invoice3 = @invoices[2]


  end

  describe 'User Story 1' do
    it "displays the merchant name" do
      visit merchant_dashboard_index_path(@merchant1)

      expect(page).to have_content(@merchant1.name)
    end
  end

  describe 'User Story 2' do
    it "displays links for merchant invoices and merchant items" do
      visit merchant_dashboard_index_path(@merchant1)

      expect(page).to have_link("Merchant Items")
      expect(page).to have_link("Merchant Invoices")
    end

    it "links me to items index" do
      visit merchant_dashboard_index_path(@merchant1)

      expect(page).to have_link("Merchant Items")
      click_on "Merchant Items"
      expect(current_path).to eq(merchant_items_path(@merchant1))
    end

    it "links me to invoices index" do
      visit merchant_dashboard_index_path(@merchant1)

      expect(page).to have_link("Merchant Invoices")
      click_on "Merchant Invoices"
      expect(current_path).to eq(merchant_invoices_path(@merchant1))
    end
  end
end
