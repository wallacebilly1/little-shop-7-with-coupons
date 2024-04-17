class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name, presence: true
  validates_presence_of :description, presence: true
  validates_presence_of :unit_price, presence: true

  enum status: { "Enabled" => 0, 
  "Disabled" => 1 }

  def format_inv_date(invoice_id)
    invoice = Invoice.find_by(id: invoice_id)
    invoice.format_date
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def order_date
    self.invoices.order(created_at: :asc)
  end

  def top_selling_day
        date = invoices
                    .joins(:transactions, :invoice_items)
                    .select('invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity)')
                    .where("transactions.result = ?", 0)
                    .group("invoices.created_at")
                    .order(Arel.sql('sum(invoice_items.unit_price * invoice_items.quantity) DESC, invoices.created_at DESC'))
                    .limit(1)        
                    .first
                    .created_at

        formatted_date = date.strftime("%A, %B %d, %Y")  
  end

  def format_invoice_date(invoice)
    invoice.created_at.strftime("%A, %B %d, %Y")
  end
end