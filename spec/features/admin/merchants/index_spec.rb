require "rails_helper"

RSpec.describe "Admin Merchants Index" do
  before(:each) do
    @merchant1 = create(:merchant, name: "Amazon", status: 0)
    @merchant2 = create(:merchant, name: "Walmart", status: 0)
    @merchant3 = create(:merchant, name: "Target", status: 1)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
    @merchant6 = create(:merchant)
    @merchant7 = create(:merchant)
    @merchant8 = create(:merchant)

    @invoice1 = create(:invoice)
    @invoice2 = create(:invoice)
    @invoice3 = create(:invoice)
    @invoice4 = create(:invoice)
    @invoice5 = create(:invoice)
    @invoice6 = create(:invoice)
    @invoice7 = create(:invoice)
    @invoice8 = create(:invoice)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant2)
    @item3 = create(:item, merchant: @merchant3)
    @item4 = create(:item, merchant: @merchant4)
    @item5 = create(:item, merchant: @merchant5)
    @item6 = create(:item, merchant: @merchant6)
    @item7 = create(:item, merchant: @merchant7)
    @item8 = create(:item, merchant: @merchant7)

    create_list(:invoice_item, 5, unit_price: 1000, quantity: 5, invoice: @invoice1, item: @item1)
    create_list(:invoice_item, 2, unit_price: 2000, quantity: 2, invoice: @invoice2, item: @item2)
    create_list(:invoice_item, 1, unit_price: 5000, quantity: 2, invoice: @invoice3, item: @item3)
    create_list(:invoice_item, 1, unit_price: 2000, quantity: 4, invoice: @invoice4, item: @item4)
    create_list(:invoice_item, 4, unit_price: 4000, quantity: 5, invoice: @invoice5, item: @item5)
    create_list(:invoice_item, 3, unit_price: 10000, quantity: 10, invoice: @invoice6, item: @item6)
    create_list(:invoice_item, 2, unit_price: 9000, quantity: 1, invoice: @invoice7, item: @item7)
    create_list(:invoice_item, 5, unit_price: 9000, quantity: 1, invoice: @invoice8, item: @item8)

    create(:transaction, result: 1, invoice: @invoice1)
    create(:transaction, result: 1, invoice: @invoice2)
    create(:transaction, result: 0, invoice: @invoice3)
    create(:transaction, result: 1, invoice: @invoice4)
    create(:transaction, result: 1, invoice: @invoice5)
    create(:transaction, result: 1, invoice: @invoice6)
    create(:transaction, result: 1, invoice: @invoice7)
    create(:transaction, result: 1, invoice: @invoice8)

    visit admin_merchants_path
  end
  
  # before(:each) do
  #   @merchant1 = Merchant.create(name: "Amazon", status: 0)
  #   @merchant2 = Merchant.create(name: "Walmart", status: 0)
  #   @merchant3 = Merchant.create(name: "Target", status: 1)
   
  #   visit admin_merchants_path
  # end

  describe '#User Story 24' do
    it 'displays each merchant on the page' do
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
    end
  end

  describe '#User Story 25' do
    it 'displays a list of all merchants in the system with a link to that admin merchants show page' do
      expect(page).to have_link("#{@merchant1.name}")
      expect(page).to have_link("#{@merchant2.name}")
      expect(page).to have_link("#{@merchant3.name}")
      
      within ".enabled" do
        click_on("#{@merchant1.name}")
      end

      expect(current_path).to eq(admin_merchant_path(@merchant1.id))

      expect(page).to have_content("#{@merchant1.name}")
    end
  end

  describe '#User Story 27' do
    it 'has a button to enable/disable each merchant next to their name that when clicked, updates the status' do
      within ".enabled" do
        expect(page).to have_button("Disable #{@merchant1.name}")

        click_on("Disable #{@merchant1.name}")
      end

      expect(current_path).to eq(admin_merchants_path)

      within ".disabled" do
        expect(page).to have_content(@merchant1.name)
        expect(page).to have_button("Enable #{@merchant1.name}")
      end
    end
  end

  describe '#User Story 28' do
    it 'has sections for enabled merchants and disabled merchants' do
      within ".enabled" do
        expect(page).to have_content("Enabled Merchants:")
        expect(page).to have_content("Amazon")
        expect(page).to have_content("Walmart")
      end

      within '.disabled' do
        expect(page).to have_content("Disabled Merchants:")
        expect(page).to have_content("Target")
      end
    end
  end

  describe '#User Story 29' do
    it 'has a link to create a new merchant, which creates new merchants with a default status of disabled' do
      expect(page).to have_link("New Merchant")

      click_on("New Merchant")

      fill_in :name, with: "Nike"
      click_on("Submit")

      expect(current_path).to eq(admin_merchants_path)

      within '.disabled' do
        expect(page).to have_content("Nike")
      end
    end
  end

  describe '#User Story 30' do
    it 'displays the names and total revenue of the top 5 merchants by total revenue generated' do
      within '.top-merchants' do
        expect(@merchant6.name).to appear_before(@merchant5.name)
        expect(@merchant5.name).to appear_before(@merchant7.name)
        expect(@merchant7.name).to appear_before(@merchant1.name)
        expect(@merchant1.name).to appear_before(@merchant2.name)

        expect(page).to_not have_content(@merchant3.name)
        expect(page).to_not have_content(@merchant4.name)
      end
    end

    it 'has links to that specific merchants show page' do
      within '.top-merchants' do
        expect(page).to have_link(@merchant6.name)
        expect(page).to have_link(@merchant5.name)
        expect(page).to have_link(@merchant7.name)
        expect(page).to have_link(@merchant1.name)
        expect(page).to have_link(@merchant2.name)

        click_on(@merchant2.name)

        expect(current_path).to eq admin_merchant_path(@merchant2)
      end
    end

    it 'displays the total revenue for each of the top merchants next to their name' do
      within '.top-merchants' do
        expect(page).to have_content("#{@merchant6.name} - $3,000.00 in sales")
        expect(page).to have_content("#{@merchant5.name} - $800.00 in sales")
        expect(page).to have_content("#{@merchant7.name} - $630.00 in sales")
        expect(page).to have_content("#{@merchant1.name} - $250.00 in sales")
        expect(page).to have_content("#{@merchant2.name} - $80.00 in sales")
      end
    end
  end
end

