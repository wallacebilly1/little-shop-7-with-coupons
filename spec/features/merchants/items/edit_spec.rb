require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  before(:each) do
    @merchant1 = create(:merchant, id: 1)

    @items_list1 = create_list(:item, 2, merchant: @merchant1 )
    @item1 = @items_list1[0]
    @item2 = @items_list1[1]
  end

  describe 'User story 8' do
    it 'has a form to update a merchant item' do
      visit edit_merchant_item_path(@merchant1, @item1)

      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Unit Price')
    end

    it 'redirects back to merchant item show page with new info' do
      visit edit_merchant_item_path(@merchant1, @item1)

      fill_in 'Name', with: 'Blah Blah'
      fill_in 'Description', with: 'Whatever'
      fill_in 'Unit Price', with: '666'

      click_on 'Submit'

      expect(current_path).to eq merchant_item_path(@merchant1, @item1)
      expect(page).to have_content('Blah Blah')
      expect(page).to have_content('Whatever')
      expect(page).to have_content('666')
    end

    it 'flashes a message when the item info is successfully updated' do
      visit edit_merchant_item_path(@merchant1, @item1)

      
      fill_in 'Name', with: 'Blah Blah'
      fill_in 'Description', with: 'Whatever'
      fill_in 'Unit Price', with: '666'

      click_on 'Submit'

      expect(page).to have_content('Item successfully updated! :)')
    end

    it "redirects back to form page if the form is not fully filled in" do
      visit edit_merchant_item_path(@merchant1, @item1)

      
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'Whatever'
      fill_in 'Unit Price', with: '666'

      expect(page).to have_button("Submit")
      click_on 'Submit'
      expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item1))
    end
  end
end