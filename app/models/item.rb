class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name, presence: true
  validates_presence_of :description, presence: true
  validates_presence_of :unit_price, presence: true
end