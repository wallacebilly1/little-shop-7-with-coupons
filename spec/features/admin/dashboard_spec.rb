require "rails_helper"

RSpec.describe "Admin Dashboard" do

  describe '#US 19' do
    it 'Displays Dashboard' do
      # When I visit the admin dashboard (/admin)
      visit admin_path
      # Then I see a header indicating that I am on the admin dashboard
      expect(page).to have_content("Admin Dashboard")

    end
  end
end