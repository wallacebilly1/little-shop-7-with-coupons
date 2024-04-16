require 'rails_helper'

RSpec.describe "Merchant Invoices Show" do
  before(:each) do
    @merchant1 = create(:merchant, id: 1)
    @merchant2 = create(:merchant, id: 2)

    @items_list1 = create_list(:item, 4, merchant: @merchant1 )
    @item1 = @items_list1[0]
    @item2 = @items_list1[1]
    @item3 = @items_list1[2]
    @item4 = @items_list1[3]

    @items_list2 = create_list(:item, 2, merchant: @merchant2 )
    @item5 = @items_list2[0]
    @item6 = @items_list2[1]

    @customers = create_list(:customer, 4)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]
    @customer5 = create(:customer) 

    @invoice1 = create(:invoice, customer: @customer1, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
    @invoice2 = create(:invoice, customer: @customer5, created_at: Time.utc(2006, 1, 12, 1, 0, 0))


    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice2.id, status: 2)

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

  describe 'User Story 16' do
    it "Displays an item name" do
      visit merchant_invoice_path(@merchant1, @invoice1)

      expect(page).to have_content(@item1.name)
      expect(page).to_not have_content(@item5.name)
    end

    it "Displays a invoice items quantity, unit price, and status" do
      visit merchant_invoice_path(@merchant1, @invoice1)

      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@invoice_item1.unit_price)
      expect(page).to have_content(@invoice_item1.status)

      # expect(page).to_not have_content(@invoice_item2.quantity)
      # expect(page).to_not have_content(@invoice_item2.unit_price)
      # expect(page).to_not have_content(@invoice_item2.status)
    end
  end

  describe 'User Story 18' do
    it "has a select field for a invoice item's status" do
      visit merchant_invoice_path(@merchant1, @invoice1)
      
      within "#invoice-item#{@invoice_item1.id}" do
        expect(page).to have_select('Status', with_options: ['pending', 'packaged', 'shipped'])
        expect(page).to have_select('Status', selected: 'pending')
        page.select 'packaged', from: 'Status'
        expect(page).to have_select('Status', selected: 'packaged')
      end
    end

    it "has a button to update the invoice item status" do
      visit merchant_invoice_path(@merchant1, @invoice1)

      within "#invoice-item#{@invoice_item1.id}" do
        expect(page).to have_select('Status', with_options: ['pending', 'packaged', 'shipped'])
        page.select 'packaged', from: 'Status'
        expect(page).to have_select('Status', selected: 'packaged')

        expect(page).to have_button("Update Item Status")
        click_on "Update Item Status"
      end
      expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))
      expect(page).to have_content("packaged")
    end
  end

  describe 'User story 17' do
    it 'has the total revenue generated from all items on the invoice' do
      visit merchant_invoice_path(@merchant1, @invoice1)

      within "#total-revenue" do
        expect(page).to have_content("Revenue from All Items: $#{@invoice1.total_revenue_in_dollars}")
      end
    end
  end
end