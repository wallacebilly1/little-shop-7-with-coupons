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
    it "lists all of the names of the merchats items" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
      expect(page).to_not have_content(@item4.name)
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
end