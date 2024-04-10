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

  end

  describe '#US 19' do
    it 'displays the dashboard' do
      # When I visit the admin dashboard (/admin)
      visit admin_path
      # Then I see a header indicating that I am on the admin dashboard
      expect(page).to have_content("Admin Dashboard")
    end
  end

  describe '#20' do
    it 'displays links to the admin merchants and invoices pages' do
      # When I visit the admin dashboard (/admin)
      visit admin_path
      # Then I see a link to the admin merchants index (/admin/merchants)
      # And I see a link to the admin invoices index (/admin/invoices)
      expect(page).to have_link("Merchants", href: admin_merchants_path)
      expect(page).to have_link("Invoices", href: admin_invoices_path)
    end
  end

  describe '#21' do
    it 'shows the names of the top 5 customers in terms of successful transactions' do
      # When I visit the admin dashboard (/admin)
      visit admin_path
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
      visit admin_path
      # And next to each customer name I see the number of successful transactions they have
      # conducted
      within "#customer-#{@customer1.id}" do
        expect(page).to have_content ("#{@customer1.name} - #{@customer1.succesful_transactions} purchases")
      end

      within "#customer-#{@customer2.id}" do
        expect(page).to have_content ("#{@customer2.name} - #{@customer2.succesful_transactions} purchases")
      end

      within "#customer-#{@customer3.id}" do
        expect(page).to have_content ("#{@customer3.name} - #{@customer3.succesful_transactions} purchases")
      end

      within "#customer-#{@customer4.id}" do
        expect(page).to have_content ("#{@customer4.name} - #{@customer4.succesful_transactions} purchases")
      end
      
      within "#customer-#{@customer5.id}" do
        expect(page).to have_content ("#{@customer5.name} - #{@customer5.succesful_transactions} purchases")
      end
    end
  end
end