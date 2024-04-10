require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant1 = create(:merchant)

    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice1 = @invoices[0]
    @invoice2 = @invoices[1]
    @invoice3 = @invoices[2]

    @items = create_list(:item, 3, invoice: @invoice1)
    @item1 = @items[0]
    @item1 = @items[1]
    @item1 = @items[2]
  end

  describe 'User Story 1' do
    it "displays the merchant name" do
      visit merchants_dashboard_index_path

      expect(page).to have_content(@merchant1.name)
    end
  end

  describe 'User Story 2' do
    it "displays links for merchant invoices and merchant items" do
      visit merchants_dashboard_index_path

      expect(page).to have_link("merchant items")
      expect(page).to have_link("merchant invoices")
    end
  end
end
