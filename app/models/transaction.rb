class Transaction < ApplicationRecord
  has_many :invoices

  enum result: { success: 0, failed: 1 }
end