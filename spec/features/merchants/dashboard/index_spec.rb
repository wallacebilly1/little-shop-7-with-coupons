require 'rails_helper'

RSpec.describe "Merchant Dashboard Index" do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant, name: "Amazon")

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
    @invoice6 = create(:invoice, customer_id: @customer4.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @invoice7 = create(:invoice, customer_id: @customer5.id, created_at: Time.utc(2024, 4, 6, 12, 0, 0))
    @invoice8 = create(:invoice, customer_id: @customer6.id, created_at: Time.utc(2024, 4, 7, 12, 0, 0))

    @invoice1_transactions = create_list(:transaction, 5, invoice: @invoice1)
    @transaction1 = @invoice1_transactions[0]
    @transaction2 = @invoice1_transactions[1]
    @transaction3 = @invoice1_transactions[2]
    @transaction4 = @invoice1_transactions[3]
    @transaction5 = @invoice1_transactions[4]

    @invoice4_transactions = create_list(:transaction, 4, invoice: @invoice4)
    @transaction6 = @invoice4_transactions[0]
    @transaction7 = @invoice4_transactions[1]
    @transaction8 = @invoice4_transactions[2]
    @transaction9 = @invoice4_transactions[3]

    @invoice5_transactions = create_list(:transaction, 3, invoice: @invoice5)
    @transaction10 = @invoice5_transactions[0]
    @transaction11 = @invoice5_transactions[1]
    @transaction12 = @invoice4_transactions[2]

    @invoice6_transactions = create_list(:transaction, 2, invoice: @invoice6)
    @transaction13 = @invoice6_transactions[0]
    @transaction14 = @invoice6_transactions[1]

    @invoice7_transactions = create_list(:transaction, 1, invoice: @invoice7)
    @transaction15 = @invoice7_transactions[0]
   
    @transaction16 = create(:transaction, invoice_id: @invoice2.id)
    @transaction17 = create(:transaction, invoice_id: @invoice3.id)
    @transaction18 = create(:transaction, invoice_id: @invoice6.id)
    @transaction19 = create(:transaction, invoice_id: @invoice7.id)

    @item1 = create(:item, unit_price: 1, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 1, 12, 0, 0))
    @item2 = create(:item, unit_price: 23, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 2, 12, 0, 0))
    @item3 = create(:item, unit_price: 100, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 3, 12, 0, 0))
    @item4 = create(:item, unit_price: 5, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 4, 12, 0, 0))
    @item5 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item6 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item7 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item8 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item9 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))
    @item10 = create(:item, unit_price: 12, merchant_id: @merchant1.id, created_at: Time.utc(2024, 4, 5, 12, 0, 0))

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, status: 2)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id, status: 2)
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item6 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item7 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, status: 1)
    @invoice_item8 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, status: 1)
    @invoice_item9 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice6.id, status: 1)
    @invoice_item10 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice7.id, status: 1)
    @invoice_item11 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice4.id, status: 1)
    @invoice_item12 = create(:invoice_item, item_id: @item7.id, invoice_id: @invoice5.id, status: 1)
    @invoice_item13 = create(:invoice_item, item_id: @item8.id, invoice_id: @invoice6.id, status: 1)
    @invoice_item14 = create(:invoice_item, item_id: @item9.id, invoice_id: @invoice7.id, status: 1)
    @invoice_item15 = create(:invoice_item, item_id: @item10.id, invoice_id: @invoice8.id, status: 1)
  
    visit merchant_dashboard_index_path(@merchant1)
  end

  describe '#User Story 1' do
    it 'displays the merchants name' do
      expect(page).to have_content(@merchant1.name)
    end
  end

  describe '#User Story 2' do
    it 'displays links for merchant invoices and merchant items' do
      expect(page).to have_link("Merchant Items")
      
      expect(page).to have_link("Merchant Invoices")
    end

    it 'when I click on those links it takes me to the respective pages' do
      click_on "Merchant Items"
      expect(current_path).to eq(merchant_items_path(@merchant1))

      visit merchant_dashboard_index_path(@merchant1)
      
      click_on "Merchant Invoices"
      expect(current_path).to eq(merchant_invoices_path(@merchant1))
    end
  end

  describe '#User Story 3' do
    it 'displays the Merchants Top 5 Customer names, ordered by successful transactions' do
      within "#top-5-customers" do
        expect(page).to have_content(@customer1.name)
        expect(page).to have_content(@customer2.name)
        expect(page).to have_content(@customer3.name)
        expect(page).to have_content(@customer4.name)
        expect(page).to have_content(@customer5.name)

        expect(page).to_not have_content(@customer6.name)

        expect(@customer1.name).to appear_before(@customer2.name)
        expect(@customer2.name).to appear_before(@customer3.name)
        expect(@customer3.name).to appear_before(@customer4.name)
        expect(@customer4.name).to appear_before(@customer5.name)
      end
    end

    it 'displays the number of succesful transactions next to each name' do
      within "#merchant-#{@customer1.id}" do
        expect(page).to have_content("Number of Transactions: 21")
      end

      within "#merchant-#{@customer4.id}" do
        expect(page).to have_content("Number of Transactions: 6")
      end
    end
  end

  describe '#User Story 4' do
    it 'displays a section for items ready to ship with item names' do
      within "#items-ready-to-ship" do
        expect(page).to have_content(@item4.name)
        expect(page).to have_content(@item5.name)

        expect(page).to_not have_content(@item1.name)
        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end

    it 'each invoice has a link to its show page' do
      within "#items-ready-to-ship" do
        expect(page).to have_content(@item4.name)
        within "#item-#{@item4.id}" do
          expect(page).to have_link("#{@invoice4.id}")
          click_on "#{@invoice4.id}"
          expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice4))
        end
      end
    end
  end

  describe '#User story 5' do
    it 'displays the formatted creation date of the invoice next to each items name' do

      within "#items-ready-to-ship" do
        expect(page).to have_content("Invoice Created On Monday, September 13, 2004")
        expect(page).to have_content("Invoice Created On Thursday, January 12, 2006")
        expect(page).to have_content("Invoice Created On Friday, April 05, 2024")
        expect(page).to have_content("Invoice Created On Saturday, April 06, 2024")
        expect(page).to have_content("Invoice Created On Saturday, April 06, 2024")
      end
    end

    it 'lists items from oldest to newest by invoice creation date' do
      within "#items-ready-to-ship" do
        expect(@item6.name).to appear_before(@item7.name)
        expect(@item7.name).to appear_before(@item8.name)
        expect(@item8.name).to appear_before(@item9.name)
        expect(@item9.name).to appear_before(@item10.name)
        expect(@item10.name).to_not appear_before(@item8.name)
        expect(@item9.name).to_not appear_before(@item6.name)
        expect(@item8.name).to_not appear_before(@item6.name)
      end
    end
  end

  describe "Coupons User Story 1" do
    it "displays a link to view all of that merchants coupons" do
      within ".coupons" do
        expect(page).to have_link("View Your Coupons")

        click_on "View Your Coupons"

        expect(current_path).to eq(merchant_coupons_path(@merchant1))
      end
    end
  end
end