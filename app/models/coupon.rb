class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :disc_type, presence: true
  validates :disc_int, presence: true, numericality: true

  enum status: [ :active, :inactive]
  enum disc_type: [ :percent, :dollar]

  def formatted_disc
    if disc_type == "percent"
      "#{disc_int}%"
    else 
      "$#{disc_int}"
    end
  end
end