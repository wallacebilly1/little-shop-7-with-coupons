class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.top_customers
    self.joins(:transactions)
        .where('result = ?', 0)
        .select("customers.*, count('transactions.result') as top_result")
        .group(:id)
        .order("top_result desc")
        .limit(5)
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end
end