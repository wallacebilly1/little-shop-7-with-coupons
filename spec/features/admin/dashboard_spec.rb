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

  describe '#20' do
    it 'see mechants link' do
      # When I visit the admin dashboard (/admin)
      visit admin_path
      # Then I see a link to the admin merchants index (/admin/merchants)
      expect(page).to have_link("Merchants", href: admin_merchants_path)
      expect(page).to have_link("Invoices", href: admin_invoices_path)

      # And I see a link to the admin invoices index (/admin/invoices)      
    end
  end
end