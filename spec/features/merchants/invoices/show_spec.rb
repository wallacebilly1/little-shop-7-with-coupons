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
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, status: 0)
    @invoice_item3 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice2.id, status: 2)

    visit merchant_invoice_path(@merchant1, @invoice1)
  end

  describe '#User Story 15' do
    it 'displays the invoice id and status' do
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
    end

    it 'displays the invoice creation date in [Monday, July 18, 2019] format' do
      expect(page).to have_content("Monday, September 13, 2004")
    end

    it 'displays the customers first and last name' do
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
    end
  end

  describe '#User Story 16' do
    it 'displays all items on that invoice' do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item5.name)
    end

    it 'displays the quantity, unit_price and status for each item' do
      within "#invoice-item#{@invoice_item1.id}" do
        expect(page).to have_content("Item Name: #{@invoice_item1.item.name}")
        expect(page).to have_content("Total Price: #{@invoice_item1.unit_price}")
        expect(page).to have_content("Status: #{@invoice_item1.status}")
      end

      within "#invoice-item#{@invoice_item2.id}" do
        expect(page).to have_content("Item Name: #{@invoice_item2.item.name}")
        expect(page).to have_content("Total Price: #{@invoice_item2.unit_price}")
        expect(page).to have_content("Status: #{@invoice_item2.status}")
      end
    end
  end

  describe '#User Story 17' do
  it 'displays the total revenue from all items on the invoice' do
    within "#revenue" do
      expect(page).to have_content("Invoice Subtotal: $#{@invoice1.revenue_subtotal_in_dollars}")
      end
    end
  end

  describe '#User Story 18' do
    it "displays each items status as a select field with the current status displayed" do
      within "#invoice-item#{@invoice_item1.id}" do
        expect(page).to have_select('Status', with_options: ['pending', 'packaged', 'shipped'])
        expect(page).to have_select('Status', selected: 'pending')
      end
      within "#invoice-item#{@invoice_item2.id}" do
        expect(page).to have_select('Status', with_options: ['pending', 'packaged', 'shipped'])
        expect(page).to have_select('Status', selected: 'pending')
      end
    end

    it "when I click the select field, I can select a new status and click 'Update Item Status' and be redirected to the show page, seeing the status updated" do
      within "#invoice-item#{@invoice_item1.id}" do
        expect(page).to have_select('Status', with_options: ['pending', 'packaged', 'shipped'])
        expect(page).to have_select('Status', selected: 'pending')

        page.select 'packaged', from: 'Status'
        expect(page).to have_select('Status', selected: 'packaged')

        expect(page).to have_button("Update Item Status")
        click_on "Update Item Status"
      end

      expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))

      within "#invoice-item#{@invoice_item1.id}" do
        expect(page).to have_select('Status', selected: 'packaged')
        expect(page).to_not have_select('Status', selected: 'pending')
      end
    end
  end

  describe "Coupons User Story 7" do
    it "displays the subtotal for that invoice" do
      within "#revenue" do
        expect(page).to have_content("Invoice Subtotal: $#{@invoice1.revenue_subtotal_in_dollars}")
      end
    end

    it "displays the grand total revenue after the coupon is applied" do
      within "#revenue" do
        expect(page).to have_content("Invoice Total Revenue (after coupon): $#{@invoice1.revenue_grand_total_in_dollars}")
      end
    end

    it "displays the name and code of the coupon used for that order, with a link to that coupon's show page" do
      within "#revenue" do
        expect(page).to have_content("Coupon Name: #{@coupon1.name}")
        expect(page).to have_link("#{@coupon1.name}")
        expect(page).to have_content("Coupon Discount: #{@coupon1.formatted_disc}")
        expect(page).to have_content("Coupon Discount: #{@coupon1.formatted_disc}")

        click_on "#{@coupon1.name}"

        expect(current_path).to eq merchant_coupon_path(@merchant1, @coupon1)
      end
    end

    it "doesn't display coupon information or grand total revenue, if a coupon is not present on invoice" do
      visit merchant_invoice_path(@merchant2, @invoice5) 

      within "#revenue" do
        expect(page).to_not have_content("Invoice Total Revenue (after coupon)")
        expect(page).to_not have_content("Coupon Name:")
        expect(page).to_not have_content("Coupon Discount:")
      end
    end
  end
end