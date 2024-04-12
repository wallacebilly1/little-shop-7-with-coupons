require 'rails_helper'

RSpec.describe "New Merchant Item Page" do
  before(:each) do
    @customers = create_list(:customer, 10)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]
    @customer5 = @customers[4]
    @customer6 = @customers[5]

    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice1 = @invoices[0]
    @invoice2 = @invoices[1]
    @invoice3 = @invoices[2]
    @invoice4 = create(:invoice, customer_id: @customer2.id, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
    @invoice5 = create(:invoice, customer_id: @customer3.id, created_at: Time.utc(2006, 1, 12, 1, 0, 0))
    @invoice6 = create(:invoice, customer_id: @customer4.id)
    @invoice7 = create(:invoice, customer_id: @customer5.id)
    @invoice8 = create(:invoice, customer_id: @customer6.id)

    @invoice1_transactions = create_list(:transaction, 4, invoice: @invoice1)
    @invoice4_transactions = create_list(:transaction, 3, invoice: @invoice4)
    @invoice5_transactions = create_list(:transaction, 2, invoice: @invoice5)

    @transaction1 = @invoice1_transactions[0]
    @transaction2 = @invoice1_transactions[1]
    @transaction3 = @invoice1_transactions[2]
    @transaction4 = @invoice1_transactions[3]
    @transaction5 = @invoice4_transactions[0]
    @transaction6 = @invoice4_transactions[1]
    @transaction7 = @invoice4_transactions[2]
    @transaction8 = @invoice5_transactions[0]
    @transaction9 = @invoice5_transactions[1]
    @transaction10 = create(:transaction, invoice_id: @invoice2.id)
    @transaction11 = create(:transaction, invoice_id: @invoice3.id)
    @transaction12 = create(:transaction, invoice_id: @invoice6.id)
    @transaction13 = create(:transaction, invoice_id: @invoice7.id)

    @merchant1 = create(:merchant, name: "Amazon")

    @item1 = create(:item, unit_price: 1, merchant_id: @merchant1.id)
    @item2 = create(:item, unit_price: 23, merchant_id: @merchant1.id)
    @item3 = create(:item, unit_price: 100, merchant_id: @merchant1.id)
    @item4 = create(:item, unit_price: 5, merchant_id: @merchant1.id)
    @item5 = create(:item, unit_price: 12, merchant_id: @merchant1.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, status: 2)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id, status: 2)
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item6 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item7 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, status: 1)
  end
  
  describe 'User story 11' do
    it 'has a form to create a new item' do
      visit new_merchant_item_path(@merchant1)

      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Unit Price')
    end
      

    it 'redirects to the items index page after successful creation and displays new item' do
      visit new_merchant_item_path(@merchant1)

      fill_in 'Name', with: 'Blah'
      fill_in 'Description', with: 'LDLKSDJLK'
      fill_in 'Unit Price', with: '20'

      expect(page).to have_button("Create a New Item")
      click_on 'Create a New Item'
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    
      expect(page).to have_content('Blah')      
      expect(page).to have_content('LDLKSDJLK')      
      expect(page).to have_content('20')      
    end

    it 'creates an item with a default status of disabled' do
      visit new_merchant_item_path(@merchant1)

      fill_in 'Name', with: 'Blah'
      fill_in 'Description', with: 'LDLKSDJLK'
      fill_in 'Unit Price', with: '20'
      click_on 'Create a New Item'

      expect(page).to have_content('disabled')
      expect(current_path).to eq(merchant_items_path(@merchant1))
    end
  end
end