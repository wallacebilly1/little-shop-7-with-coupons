class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: { "in progress" => 0, 
                 "completed" => 1, 
                 "cancelled" => 2 }

  def format_date
    self.created_at.strftime("%A, %B %d, %Y")
  end

  def self.incomplete_invoices
    select("invoices.*")
      .joins(:invoice_items)
      .where("invoice_items.status != 2")
      .distinct
      .order(:created_at)
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def total_revenue_in_dollars
    cents = self.total_revenue
    formatted_dollars = cents / 100.00
    formatted_dollars
  end

  def self.order_date
    joins(:invoice_items)
    .select("invoices.*")
    .order(created_at: :asc)
  end

end