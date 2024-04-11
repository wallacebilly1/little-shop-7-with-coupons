require "rails_helper"

RSpec.describe "Merchants Index Page " do
  before(:each) do
    @merchant1 = Merchant.create(name: "Amazon")
    @merchant2 = Merchant.create(name: "Walmart")
    @merchant3 = Merchant.create(name: "Target")
  end

  describe '#us 24' do
    it 'see each merchant on the page ' do
      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then I see the name of each merchant in the system
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
     
    end
  end

  describe '#us 25' do
    it 'see a specific merchants show page ' do
      visit admin_merchants_path
      # When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
      expect(page).to have_link("#{@merchant1.name}")
      click_on("#{@merchant1.name}")
      # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
      expect(current_path).to eq(admin_merchant_path(@merchant1.id))
      # And I see the name of that merchant
      expect(page).to have_content("#{@merchant1.name}")
    end
  end
end
