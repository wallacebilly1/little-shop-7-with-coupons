class Customer < ApplicationRecord
  has_many :invoices

  def name
    "#{self.first_name}  #{self.last_name}"
  end
end