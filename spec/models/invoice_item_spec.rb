require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  before(:each) do

  end

  describe "class methods" do

  end

  describe "instance methods" do
    
  end
end