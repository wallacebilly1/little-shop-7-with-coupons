class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: {"Enabled" => 0, "Disabled" => 1}

  
  def top_5_customers
    #binding.pry
    self.customers.select("customers.*, count(*)").joins(:transactions)
    .group(:id).order("count desc").limit(5)
    
   
  end
end