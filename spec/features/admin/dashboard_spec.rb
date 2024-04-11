require "rails_helper"

RSpec.describe "Admin Dashboard" do
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
    @invoice4 = create(:invoice, customer_id: @customer2.id)
    @invoice5 = create(:invoice, customer_id: @customer3.id)
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
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice3.id, status: 1)
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice3.id, status: 1)
    @invoice_item6 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice3.id, status: 1)
    #invoice 1-one pending invoice_item, one shipped
    #invoice 2-one shipped invoice_item
    #invoice 3-all pending invoice_items
    visit admin_path
  end

  describe '#US 19' do
    it 'displays the dashboard' do
      # Then I see a header indicating that I am on the admin dashboard
      expect(page).to have_content("Admin Dashboard")
    end
  end

  describe '#20' do
    it 'displays links to the admin merchants and invoices pages' do
      # Then I see a link to the admin merchants index (/admin/merchants)
      # And I see a link to the admin invoices index (/admin/invoices)
      expect(page).to have_link("Merchants", href: admin_merchants_path)
      expect(page).to have_link("Invoices", href: admin_invoices_path)
    end
  end

  describe '#21' do
    it 'shows the names of the top 5 customers in terms of successful transactions' do
      # Then I see the names of the top 5 customers
      # who have conducted the largest number of successful transactions
      within "#top-customers" do
        expect(page).to have_content("Top Customers")

        expect(page).to have_content(@customer1.name)
        expect(page).to have_content(@customer2.name)
        expect(page).to have_content(@customer3.name)
        expect(page).to have_content(@customer4.name)
        expect(page).to have_content(@customer5.name)
        
        expect(page).to_not have_content(@customer6.name)
      end
    end

    it 'shows the number of successful transactions they have conducted' do
      # And next to each customer name I see the number of successful transactions they have
      # conducted
      within "#customer-#{@customer1.id}" do
        expect(page).to have_content ("#{@customer1.name} - #{@customer1.transactions.count} purchases")
      end

      within "#customer-#{@customer2.id}" do
        expect(page).to have_content ("#{@customer2.name} - #{@customer2.transactions.count} purchases")
      end

      within "#customer-#{@customer3.id}" do
        expect(page).to have_content ("#{@customer3.name} - #{@customer3.transactions.count} purchases")
      end

      within "#customer-#{@customer4.id}" do
        expect(page).to have_content ("#{@customer4.name} - #{@customer4.transactions.count} purchases")
      end
      
      within "#customer-#{@customer5.id}" do
        expect(page).to have_content ("#{@customer5.name} - #{@customer5.transactions.count} purchases")
      end
    end
  end

  describe "#22" do
    it "displays a section for Incomplete Invoices" do
      # Then I see a section for "Incomplete Invoices"
      within "#incomplete-invoices" do
        expect(page).to have_content("Incomplete Invoices")
      end
    end

    it "shows a list of the ID's of all invoices with items that have not shipped" do
      # In that section I see a list of the ids of all invoices
      # That have items that have not yet been shipped (status of invoice_item)
      within "#incomplete-invoices" do
        #need to update these once I've updated setup to have invoice_items with
        # different statuses
        expect(page).to have_content("#{@invoice1.id}")
        expect(page).to have_content("#{@invoice3.id}")
        expect(page).to_not have_content("#{@invoice4.id}")
      end
    end

    it "when I click that ID's link, I am taken to that invoices' admin show page" do
      # And each invoice id links to that invoice's admin show page
      within "#incomplete-invoices" do

        click_on("Invoice #{@invoice1.id}")

        expect(page).to have_current_path(admin_invoice_path(@invoice1))
      end
    end
  end
end