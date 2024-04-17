require 'rails_helper'

RSpec.describe "Merchant Items Show" do
  before(:each) do
    @merchant1 = create(:merchant, id: 1)
    @merchant2 = create(:merchant, id: 2)

    @items_list1 = create_list(:item, 2, merchant: @merchant1 )
    @item1 = @items_list1[0]
    @item2 = @items_list1[1]
    @items_list2 = create_list(:item, 2, merchant: @merchant2 )
    @item3 = @items_list2[0]
    @item4 = @items_list2[1]
  end

  describe '#User Story 7' do
    it "displays a merchants item and its attributes" do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(number_to_currency(@item1.unit_price/100.00))

      expect(page).to_not have_content(@item2.name)
      expect(page).to_not have_content(@item2.description)
      expect(page).to_not have_content(@item2.unit_price)
    end
  end
  
  describe 'User story 8' do
    it 'has a link to edit the item and redirects to edit item page' do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_content("Edit Item")
      
      click_on "Edit Item"
      
      expect(current_path).to eq edit_merchant_item_path(@merchant1, @item1)
    end
  end
end