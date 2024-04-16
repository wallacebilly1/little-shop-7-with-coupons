require "rails_helper"

RSpec.describe "Admin Invoices Show" do
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

    visit admin_invoice_path(@invoice1.id)
  end

  describe '#User Story 33' do
    it 'displays all information related to that invoice, including status, created_on date, and customer name' do
      expect(page).to have_content("Invoice ##{@invoice1.id}")
      
      within "#invoice-summary" do
        expect(page).to have_field("invoice_status", with: 0)
        expect(page).to have_content("Created On: #{@invoice1.format_date}")
        expect(page).to have_content("Customer: #{@invoice1.customer.name}")
        
        expect(page).to_not have_content("Invoice ##{@invoice2.id}")
        expect(page).to_not have_content("Invoice ##{@invoice3.id}")
      end
    end
  end

  describe '#User Story 34' do
    it 'displays all items from that invoice, including item name, quantity, price, and invoice item status' do
      within "#invoice-items" do
        expect(page).to have_content("Items on this Invoice")
      
        expect(page).to have_content("#{@item1.name}")
        expect(page).to have_content("#{@item2.name}")
        expect(page).to_not have_content("#{@item3.name}")
        expect(page).to_not have_content("#{@item5.name}")
      end

      within "#item-#{@invoice_item1.id}" do
        expect(page).to have_content("#{@invoice_item1.quantity}")
        expect(page).to have_content("#{number_to_currency(@invoice_item1.unit_price_in_dollars, unit: "$")}")
        expect(page).to have_content("#{@invoice_item1.status}")
      end

      within "#item-#{@invoice_item2.id}" do
        expect(page).to have_content("#{@invoice_item2.quantity}")
        expect(page).to have_content("#{number_to_currency(@invoice_item2.unit_price_in_dollars, unit: "$")}")
        expect(page).to have_content("#{@invoice_item2.status}")
      end
    end
  end

  describe '#User Story 35' do
    it 'displays the total revenue that will be generated for an invoice' do
      @expected_revenue = number_to_currency(@invoice1.total_revenue_in_dollars, unit: "$")
      within "#invoice-summary" do
        expect(page).to have_content("Total Revenue: #{@expected_revenue}")
      end
    end
  end

  describe '#User Story 36' do
    it 'displays the invoice status as a select field, where I see the current invoice status selected' do
      expect(page).to have_field("invoice_status", with: 0)
    end

    it 'can change the status of an invoice through this button and be returned to the invoice show page, seeing the changes made' do
      within "#update-invoice" do
        page.select "Completed", from: 'invoice_status'
        click_button 'Update Invoice Status'
      end

      expect(current_path).to eq(admin_invoice_path(@invoice1.id))
      expect(page).to have_field("invoice_status", with: 1)
      expect(page).to_not have_field("invoice_status", with: 0)
    end
  end
end