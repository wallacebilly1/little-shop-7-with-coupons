require 'rails_helper'

RSpec.describe "Merchant Invoices Index" do
  before(:each) do
    @merchant1 = create(:merchant, id: 1)
    @merchant2 = create(:merchant, id: 2)

    @items_list1 = create_list(:item, 4, merchant: @merchant1 )
    @item1 = @items_list1[0]
    @item2 = @items_list1[1]
    @item3 = @items_list1[2]
    @item4 = @items_list1[3]
    @items_list2 = create_list(:item, 2, merchant: @merchant2 )
    @item5 = @items_list1[0]
    @item6 = @items_list1[1]

    @customers = create_list(:customer, 4)
    @customer1 = @customers[0]
    @customer2 = @customers[1]
    @customer3 = @customers[2]
    @customer4 = @customers[3]
    @customers2 = create_list(:customer, 1)
    @customer5 = @customers2[0]

    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice1 = @invoices[0]
    @invoice2 = @invoices[1]
    @invoice3 = @invoices[2]
    @invoices2 = create_list(:invoice, 1, customer: @customer2)
    @invoice4 = @invoices2[0]
  end

  describe 'User Story 14' do
    xit "displays all of the invoices with links to show" do
      visit merchant_invoices_path(@merchant1)

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice2.id)
      expect(page).to have_content(@invoice3.id)
      expect(page).to_not have_content(@invoice4.id)

      expect(page).to have_link(@invoice1.id)
      expect(page).to have_link(@invoice2.id)
      
      expect(page).to have_link(@invoice3.id)

      click_on "#{@invoice1.id}"
      expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))
    end
  end
end