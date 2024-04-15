class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: {"Enabled" => 0, "Disabled" => 1}

  def self.top_five_merchants
    Merchant.joins(:transactions)
            .where("result = 1")
            .distinct
            .select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue")
            .group(:id)
            .order("total_revenue desc")
            .limit(5)
  end
end