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
end