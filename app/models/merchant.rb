class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: {"Enabled" => 0, "Disabled" => 1}

  validates :name, presence: true

  def top_5_customers
    self.customers.select("customers.*, count(*) as count_transactions")
    .where("result = 0")
    .joins(:transactions)
    .group(:id)
    .order("count_transactions desc")
    .limit(5)
  end

  def self.top_five_merchants
    Merchant.joins(:transactions)
            .where("result = 1")
            .select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue")
            .group(:id)
            .order("total_revenue desc")
            .limit(5)
  end

  def packaged_items
    self.items.joins(:invoice_items)
    .where("invoice_items.status = 1")
    .select("invoice_items.invoice_id, items.*")
  end
end