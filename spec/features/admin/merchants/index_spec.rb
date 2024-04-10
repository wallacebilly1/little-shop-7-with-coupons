require "rails_helper"

RSpec.describe "Merchants Index Page " do
  before(:each) do
    @merchants = create_list(:merchant, 3)
    @merchant1 = @merchants[0]
    @merchant2 = @merchants[1]
    @merchant3 = @merchants[2]
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
end
