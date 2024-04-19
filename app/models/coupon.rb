class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :disc_type, presence: true
  validates :disc_int, presence: true, numericality: true

  enum status: [ :active, :inactive]
  enum disc_type: [ :percent, :dollar]
end