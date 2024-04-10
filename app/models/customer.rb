class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def self.top_customers
    select("customers.*, count(*)").joins(:transactions)
    .group(:id).order("count desc").limit(5)
  end
end