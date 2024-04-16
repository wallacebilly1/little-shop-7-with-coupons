require "rails_helper"

RSpec.describe "Admin Merchants Index" do
  before(:each) do
    @merchant1 = Merchant.create(name: "Amazon", status: 0)
    @merchant2 = Merchant.create(name: "Walmart", status: 0)
    @merchant3 = Merchant.create(name: "Target", status: 1)
   
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
      # require 'pry'; binding.pry
      click_on("#{@merchant1.name}")
      # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
      expect(current_path).to eq(admin_merchant_path(@merchant1.id))
      # And I see the name of that merchant
      expect(page).to have_content("#{@merchant1.name}")
    end
  end

  describe '#us 27' do
    it 'has a button of enable or disable' do
      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then next to each merchant name I see a button to disable or enable that merchant.
      within ".enabled" do
        expect(page).to have_button("Disable #{@merchant1.name}")
        # When I click this button
        click_on("Disable #{@merchant1.name}")
      end
      # Then I am redirected back to the admin merchants index
      expect(current_path).to eq(admin_merchants_path)
      # And I see that the merchant's status has changed
      within ".disabled" do
        expect(page).to have_button("Enable #{@merchant1.name}")
        # expect(page).to have_content("Status: Disabled")
      end
    end
  end

  describe '#us 28' do
    it 'Has a section one for enabled merchants and the other for disabled merchants' do

      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
      within ".enabled" do
        expect(page).to have_content("Enabled Merchants:")
        expect(page).to have_content("Amazon")
        expect(page).to have_content("Walmart")

      end
      # And I see that each Merchant is listed in the appropriate section
      # save_and_open_page
      within '.disabled' do
        expect(page).to have_content("Disabled Merchants:")
        expect(page).to have_content("Target")
      end
    end
  end

  describe '#us 29' do
    it 'Creates a new merchant' do
      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # I see a link to create a new merchant.
      expect(page).to have_link("New Merchant")
      # When I click on the link,
      click_on("New Merchant")
      # I am taken to a form that allows me to add merchant information.
      fill_in :name, with: "Nike"
      # When I fill out the form I click ‘Submit’
      click_on("Submit")
      # Then I am taken back to the admin merchants index page
      expect(current_path).to eq(admin_merchants_path)
      # And I see the merchant I just created displayed
      within '.disabled' do
        
        expect(page).to have_content("Nike")
        # save_and_open_page
      end
      # And I see my merchant was created with a default status of disabled.

    end
  end
end

