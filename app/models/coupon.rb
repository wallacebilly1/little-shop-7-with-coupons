class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  enum status: [ :active, :inactive]
  enum disc_type: [ :percent, :dollar]
end