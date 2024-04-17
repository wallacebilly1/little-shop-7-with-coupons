require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  before(:each) do
    @merchant1 = create(:merchant, id: 1)

    @items_list1 = create_list(:item, 2, merchant: @merchant1 )
    @item1 = @items_list1[0]
    @item2 = @items_list1[1]
  end

  describe 'User Story 8' do
    it 'has a form to update the merchant item, which displays the existing item attribute information' do
      visit edit_merchant_item_path(@merchant1, @item1)

      expect(page).to have_field(:name, with: @item1.name)
      expect(page).to have_field(:description, with: @item1.description)
      expect(page).to have_field(:unit_price, with: @item1.unit_price)
    end

    it 'redirects back to merchant item show page with new info and displays a flash message for successfully updating item' do
      visit edit_merchant_item_path(@merchant1, @item1)

      fill_in :name, with: 'Blah Blah'
      fill_in :description, with: 'Whatever'
      fill_in :unit_price, with: '666'
      click_on 'Submit'

      expect(current_path).to eq merchant_item_path(@merchant1, @item1)

      expect(page).to have_content('Item successfully updated! :)')

      expect(page).to have_content('Blah Blah')
      expect(page).to have_content('Description: Whatever')
      expect(page).to have_content('Unit Price: $6.66')
    end

    it 'redirects back to form page if the form is not fully filled in' do
      visit edit_merchant_item_path(@merchant1, @item1)

      fill_in :name, with: ''
      fill_in :description, with: 'Whatever'
      fill_in :unit_price, with: '666'
      click_on 'Submit'

      expect(page).to have_content("Please ensure all fields are complete")
      expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item1))
    end
  end
end