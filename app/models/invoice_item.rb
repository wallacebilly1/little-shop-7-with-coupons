class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: { pending: 0, packaged: 1, shipped: 2 }

  # def invoice_item_total_price
  #   self.sum { |item| item.quantity * item.unit_price }
  # end
end