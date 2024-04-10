require 'rails_helper'

RSpec.describe "Merchant Invoices Show" do
  before(:each) do
    @merchant1 = create(:merchant, id: 1)

    @items_list1 = create_list(:item, 4, merchant: @merchant1 )
    @item1 = @items_list1[0]
    @item2 = @items_list1[1]
    @item3 = @items_list1[2]
    @item4 = @items_list1[3]

    @customers = create_list(:customer, 4)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]

    @invoice1 = create(:invoice, customer: @customer1, created_at: "2004-13-09")
  end

  describe 'User Story 15' do
    it "Displays the invoice id and status" do
      visit merchant_invoice_path(@merchant1, @invoice1)

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
    end

    it "Displays created at in Monday, July 18, 2019 format" do
      visit merchant_invoice_path(@merchant1, @invoice1)

      expect(page).to have_content("Monday, September 13, 2004")
    end

    it "Displays the customer first and last name" do
      visit merchant_invoice_path(@merchant1, @invoice1)

      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
    end
  end
end