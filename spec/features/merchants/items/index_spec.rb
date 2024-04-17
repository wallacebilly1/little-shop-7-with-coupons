require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  before(:each) do
    @merchant1 = create(:merchant, id: 1)
    @merchant2 = create(:merchant, id: 2)

    @items_list1 = create_list(:item, 2, merchant: @merchant1 )
    @item1 = @items_list1[0]
    @item2 = @items_list1[1]
    @items_list2 = create_list(:item, 2, merchant: @merchant2 )
    @item3 = @items_list2[0]
    @item4 = @items_list2[1]
    @item5 = create(:item, merchant_id: @merchant1.id, status: 0)
    @item6 = create(:item, unit_price: 1, merchant_id: @merchant1.id, status: 1)
    @item7 = create(:item, unit_price: 23, merchant_id: @merchant1.id, status: 1)
    @item8 = create(:item, unit_price: 100, merchant_id: @merchant1.id, status: 0)
    @item9 = create(:item, unit_price: 5, merchant_id: @merchant1.id, status: 0)
    @item10 = create(:item, unit_price: 12, merchant_id: @merchant1.id, status: 0)
  
  end

  describe 'User Story 6' do
    it "lists all of the names of the merchants items" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
      expect(page).to_not have_content(@item4.name)
    end
  end

  describe '#User Story 7' do
    it "displays a link on each items name that takes me to that items show page" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_link(@item1.name)
      expect(page).to have_link(@item2.name)

      click_on @item1.name

      expect(current_path).to eq merchant_item_path(@merchant1, @item1)
    end
  end 

  describe 'User Story 9' do
    it "has a enable button for an item" do
      visit merchant_items_path(@merchant1)
   
      within "#item-#{@item1.id}" do
        expect(page).to have_button("Enable")
        click_on "Enable"
      end
      expect(current_path).to eq(merchant_items_path(@merchant1))

      expect(page).to have_content("Enabled")
    end

    it "has a disable button for an item" do 
      visit merchant_items_path(@merchant1)

      within "#item-#{@item5.id}" do
        expect(page).to have_button("Disable")
        click_on "Disable"
      end
      expect(current_path).to eq(merchant_items_path(@merchant1))

      expect(page).to have_content("Disabled")
    end
  end

  describe 'User story 11' do
    it 'has a link to create a new item' do
      visit merchant_items_path(@merchant1)

      expect(page).to have_link('Create a New Item', href: new_merchant_item_path(@merchant1))
    end
  end


  describe 'User story 10' do
    it 'shows items by enabled status' do
      visit merchant_items_path(@merchant1)

      within "#enabled-items" do 
        expect(page).to have_content(@item8.id)
        expect(page).to have_content(@item8.name)
        expect(page).to have_content(@item9.id)
        expect(page).to have_content(@item9.name)
        expect(page).to have_content(@item10.id)
        expect(page).to have_content(@item10.name)
        expect(page).to_not have_content(@item6.name)
      end
    end

    it 'shows items by disabled status' do
      visit merchant_items_path(@merchant1)

      within "#disabled-items" do 
        expect(page).to have_content(@item6.id)
        expect(page).to have_content(@item6.name)
        expect(page).to have_content(@item7.name)
        expect(page).to have_content(@item7.name)
        expect(page).to_not have_content(@item8.name)
        expect(page).to_not have_content(@item9.id)
        expect(page).to_not have_content(@item10.id)
      end
    end
  end

  describe 'User story 12' do
    it 'displays the top 5 items' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant, name: "Amazon")
  
      customers = create_list(:customer, 10)
      customer1 = customers[0]
      customer2 = customers[1]
      customer3 = customers[2]
      customer4 = customers[3]
      customer5 = customers[4]
      customer6 = customers[5]
  
      invoices = create_list(:invoice, 3, customer: customer1)
      invoice1 = invoices[0]
      invoice2 = invoices[1]
      invoice3 = invoices[2]
      invoice4 = create(:invoice, customer_id: customer2.id, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
      invoice5 = create(:invoice, customer_id: customer3.id, created_at: Time.utc(2006, 1, 12, 1, 0, 0))
      invoice6 = create(:invoice, customer_id: customer4.id)
      invoice7 = create(:invoice, customer_id: customer5.id)
      invoice8 = create(:invoice, customer_id: customer6.id)
  
      invoice1_transactions = create_list(:transaction, 5, invoice: invoice1)
      transaction1 = invoice1_transactions[0]
      transaction2 = invoice1_transactions[1]
      transaction3 = invoice1_transactions[2]
      transaction4 = invoice1_transactions[3]
      transaction5 = invoice1_transactions[4]
  
      invoice4_transactions = create_list(:transaction, 4, invoice: invoice4)
      transaction6 = invoice4_transactions[0]
      transaction7 = invoice4_transactions[1]
      transaction8 = invoice4_transactions[2]
      transaction9 = invoice4_transactions[3]
  
      invoice5_transactions = create_list(:transaction, 3, invoice: invoice5)
      transaction10 = invoice5_transactions[0]
      transaction11 = invoice5_transactions[1]
      transaction12 = invoice4_transactions[2]
  
      invoice6_transactions = create_list(:transaction, 2, invoice: invoice6)
      transaction13 = invoice6_transactions[0]
      transaction14 = invoice6_transactions[1]
  
      invoice7_transactions = create_list(:transaction, 1, invoice: invoice7)
      transaction15 = invoice7_transactions[0]
     
      transaction16 = create(:transaction, invoice_id: invoice2.id)
      transaction17 = create(:transaction, invoice_id: invoice3.id)
      transaction18 = create(:transaction, invoice_id: invoice6.id)
      transaction19 = create(:transaction, invoice_id: invoice7.id)
  
      item1 = create(:item, unit_price: 1, merchant_id: merchant1.id)
      item2 = create(:item, unit_price: 23, merchant_id: merchant1.id)
      item3 = create(:item, unit_price: 100, merchant_id: merchant1.id)
      item4 = create(:item, unit_price: 5, merchant_id: merchant1.id)
      item5 = create(:item, unit_price: 12, merchant_id: merchant1.id)
  
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, status: 0, unit_price: 10, quantity: 10)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, status: 2, unit_price: 11, quantity: 10)
      invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice2.id, status: 2, unit_price: 12, quantity: 10)
      invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id, status: 1, unit_price: 13, quantity: 10)
      invoice_item5 = create(:invoice_item, item_id: item5.id, invoice_id: invoice4.id, status: 1, unit_price: 14, quantity: 10)
      invoice_item6 = create(:invoice_item, item_id: item5.id, invoice_id: invoice4.id, status: 1, unit_price: 15, quantity: 10)
      invoice_item7 = create(:invoice_item, item_id: item5.id, invoice_id: invoice5.id, status: 1, unit_price: 16, quantity: 10)
      invoice_item8 = create(:invoice_item, item_id: item5.id, invoice_id: invoice5.id, status: 1, unit_price: 17, quantity: 10)
      invoice_item9 = create(:invoice_item, item_id: item5.id, invoice_id: invoice6.id, status: 1, unit_price: 18, quantity: 10)
      invoice_item10 = create(:invoice_item, item_id: item5.id, invoice_id: invoice7.id, status: 1, unit_price: 19, quantity: 10)

      visit merchant_items_path(merchant1)

      within "#top-5-items" do
        expect(item5.name).to appear_before(item2.name)
        expect(item2.name).to appear_before(item4.name)
        expect(item4.name).to appear_before(item1.name)
        expect(item1.name).to appear_before(item3.name)
        expect(item4.name).to_not appear_before(item5.name)
        expect(item3.name).to_not appear_before(item2.name)
      end
    end

    it 'has the item name with a link to its show page' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant, name: "Amazon")
  
      customers = create_list(:customer, 10)
      customer1 = customers[0]
      customer2 = customers[1]
      customer3 = customers[2]
      customer4 = customers[3]
      customer5 = customers[4]
      customer6 = customers[5]
  
      invoices = create_list(:invoice, 3, customer: customer1)
      invoice1 = invoices[0]
      invoice2 = invoices[1]
      invoice3 = invoices[2]
      invoice4 = create(:invoice, customer_id: customer2.id, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
      invoice5 = create(:invoice, customer_id: customer3.id, created_at: Time.utc(2006, 1, 12, 1, 0, 0))
      invoice6 = create(:invoice, customer_id: customer4.id)
      invoice7 = create(:invoice, customer_id: customer5.id)
      invoice8 = create(:invoice, customer_id: customer6.id)
  
      invoice1_transactions = create_list(:transaction, 5, invoice: invoice1)
      transaction1 = invoice1_transactions[0]
      transaction2 = invoice1_transactions[1]
      transaction3 = invoice1_transactions[2]
      transaction4 = invoice1_transactions[3]
      transaction5 = invoice1_transactions[4]
  
      invoice4_transactions = create_list(:transaction, 4, invoice: invoice4)
      transaction6 = invoice4_transactions[0]
      transaction7 = invoice4_transactions[1]
      transaction8 = invoice4_transactions[2]
      transaction9 = invoice4_transactions[3]
  
      invoice5_transactions = create_list(:transaction, 3, invoice: invoice5)
      transaction10 = invoice5_transactions[0]
      transaction11 = invoice5_transactions[1]
      transaction12 = invoice4_transactions[2]
  
      invoice6_transactions = create_list(:transaction, 2, invoice: invoice6)
      transaction13 = invoice6_transactions[0]
      transaction14 = invoice6_transactions[1]
  
      invoice7_transactions = create_list(:transaction, 1, invoice: invoice7)
      transaction15 = invoice7_transactions[0]
     
      transaction16 = create(:transaction, invoice_id: invoice2.id)
      transaction17 = create(:transaction, invoice_id: invoice3.id)
      transaction18 = create(:transaction, invoice_id: invoice6.id)
      transaction19 = create(:transaction, invoice_id: invoice7.id)
  
      item1 = create(:item, unit_price: 1, merchant_id: merchant1.id)
      item2 = create(:item, unit_price: 23, merchant_id: merchant1.id)
      item3 = create(:item, unit_price: 100, merchant_id: merchant1.id)
      item4 = create(:item, unit_price: 5, merchant_id: merchant1.id)
      item5 = create(:item, unit_price: 12, merchant_id: merchant1.id)
  
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, status: 0, unit_price: 10, quantity: 10)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, status: 2, unit_price: 11, quantity: 10)
      invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice2.id, status: 2, unit_price: 12, quantity: 10)
      invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id, status: 1, unit_price: 13, quantity: 10)
      invoice_item5 = create(:invoice_item, item_id: item5.id, invoice_id: invoice4.id, status: 1, unit_price: 14, quantity: 10)
      invoice_item6 = create(:invoice_item, item_id: item5.id, invoice_id: invoice4.id, status: 1, unit_price: 15, quantity: 10)
      invoice_item7 = create(:invoice_item, item_id: item5.id, invoice_id: invoice5.id, status: 1, unit_price: 16, quantity: 10)
      invoice_item8 = create(:invoice_item, item_id: item5.id, invoice_id: invoice5.id, status: 1, unit_price: 17, quantity: 10)
      invoice_item9 = create(:invoice_item, item_id: item5.id, invoice_id: invoice6.id, status: 1, unit_price: 18, quantity: 10)
      invoice_item10 = create(:invoice_item, item_id: item5.id, invoice_id: invoice7.id, status: 1, unit_price: 19, quantity: 10)

      visit merchant_items_path(merchant1)

      within "#top-5-items" do
        expect(page).to have_link("#{item5.name}", href: merchant_item_path(merchant1, item5))

        click_on "#{item5.name}"

        expect(current_path).to eq merchant_item_path(merchant1, item5)
      end
    end

    it 'displays the total revenue generated next to each item name' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant, name: "Amazon")
  
      customers = create_list(:customer, 10)
      customer1 = customers[0]
      customer2 = customers[1]
      customer3 = customers[2]
      customer4 = customers[3]
      customer5 = customers[4]
      customer6 = customers[5]
  
      invoices = create_list(:invoice, 3, customer: customer1)
      invoice1 = invoices[0]
      invoice2 = invoices[1]
      invoice3 = invoices[2]
      invoice4 = create(:invoice, customer_id: customer2.id, created_at: Time.utc(2004, 9, 13, 12, 0, 0))
      invoice5 = create(:invoice, customer_id: customer3.id, created_at: Time.utc(2006, 1, 12, 1, 0, 0))
      invoice6 = create(:invoice, customer_id: customer4.id)
      invoice7 = create(:invoice, customer_id: customer5.id)
      invoice8 = create(:invoice, customer_id: customer6.id)
  
      invoice1_transactions = create_list(:transaction, 5, invoice: invoice1)
      transaction1 = invoice1_transactions[0]
      transaction2 = invoice1_transactions[1]
      transaction3 = invoice1_transactions[2]
      transaction4 = invoice1_transactions[3]
      transaction5 = invoice1_transactions[4]
  
      invoice4_transactions = create_list(:transaction, 4, invoice: invoice4)
      transaction6 = invoice4_transactions[0]
      transaction7 = invoice4_transactions[1]
      transaction8 = invoice4_transactions[2]
      transaction9 = invoice4_transactions[3]
  
      invoice5_transactions = create_list(:transaction, 3, invoice: invoice5)
      transaction10 = invoice5_transactions[0]
      transaction11 = invoice5_transactions[1]
      transaction12 = invoice4_transactions[2]
  
      invoice6_transactions = create_list(:transaction, 2, invoice: invoice6)
      transaction13 = invoice6_transactions[0]
      transaction14 = invoice6_transactions[1]
  
      invoice7_transactions = create_list(:transaction, 1, invoice: invoice7)
      transaction15 = invoice7_transactions[0]
     
      transaction16 = create(:transaction, invoice_id: invoice2.id)
      transaction17 = create(:transaction, invoice_id: invoice3.id)
      transaction18 = create(:transaction, invoice_id: invoice6.id)
      transaction19 = create(:transaction, invoice_id: invoice7.id)
  
      item1 = create(:item, unit_price: 1, merchant_id: merchant1.id)
      item2 = create(:item, unit_price: 23, merchant_id: merchant1.id)
      item3 = create(:item, unit_price: 100, merchant_id: merchant1.id)
      item4 = create(:item, unit_price: 5, merchant_id: merchant1.id)
      item5 = create(:item, unit_price: 12, merchant_id: merchant1.id)
  
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, status: 0, unit_price: 10, quantity: 10)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, status: 2, unit_price: 11, quantity: 10)
      invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice2.id, status: 2, unit_price: 12, quantity: 10)
      invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice4.id, status: 1, unit_price: 13, quantity: 10)
      invoice_item5 = create(:invoice_item, item_id: item5.id, invoice_id: invoice4.id, status: 1, unit_price: 14, quantity: 10)
      invoice_item6 = create(:invoice_item, item_id: item5.id, invoice_id: invoice4.id, status: 1, unit_price: 15, quantity: 10)
      invoice_item7 = create(:invoice_item, item_id: item5.id, invoice_id: invoice5.id, status: 1, unit_price: 16, quantity: 10)
      invoice_item8 = create(:invoice_item, item_id: item5.id, invoice_id: invoice5.id, status: 1, unit_price: 17, quantity: 10)
      invoice_item9 = create(:invoice_item, item_id: item5.id, invoice_id: invoice6.id, status: 1, unit_price: 18, quantity: 10)
      invoice_item10 = create(:invoice_item, item_id: item5.id, invoice_id: invoice7.id, status: 1, unit_price: 19, quantity: 10)

      visit merchant_items_path(merchant1)

      within "#top-5-items" do
        expect(page).to have_content("Total Item Revenue: #{item1.total_revenue}")
        expect(page).to have_content("Total Item Revenue: #{item2.total_revenue}")
        expect(page).to have_content("Total Item Revenue: #{item3.total_revenue}")
        expect(page).to have_content("Total Item Revenue: #{item4.total_revenue}")
        expect(page).to have_content("Total Item Revenue: #{item5.total_revenue}")
      end
    end
  end
end