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

  # @invoice_items = @invoice.invoice_items.joins(:item).where(items: {merchant_id: @merchant.id})
  # @total_revenue = @invoice_items.sum("invoice_items.unit_price * quantity")
  # self.sum { |item| item.quantity * item.unit_price }

end