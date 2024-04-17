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

  # # top for one item at a time/instance method
  # def top_selling_day
  #   top_selling_day = 
        # self.joins(:invoices, :transactions)
      #       .select('invoices.*', sum(invoice_items.unit_price & invoice_items.quantity) AS total_revenue)
      #       .where("transactions.result = ?", 0)
      #       .group(:id)
      #       .order('total_revenue DESC')
      #       .first

  #   top_selling_day.format_date
  # end

  # def format_date
  #   self.created_at.strftime("%A, %B %d, %Y")
  # end
end