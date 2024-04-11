require "rails_helper"

RSpec.describe "Admin Merchants show page" do
  before(:each) do
    @merchants = create_list(:merchant, 3)
    @merchant1 = @merchants[0]
    @merchant2 = @merchants[1]
    @merchant3 = @merchants[2]
  end

  describe '#us 25' do
    it 'see a specific merchants show page ' do
      # When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
      visit admin_merchants_path(@merchant1)
      # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
      # And I see the name of that merchant
    end
  end
end