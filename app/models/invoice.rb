class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :coupon, optional: true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: ["in progress", "completed", "cancelled"]

  def format_date
    self.created_at.strftime("%A, %B %d, %Y")
  end

  def self.incomplete_invoices
    select("invoices.*")
      .joins(:invoice_items)
      .where("invoice_items.status != 2")
      .distinct
      .order(:created_at)
  end

  def self.best_day
    self.joins(:invoice_items)
    .select("invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order("revenue desc", "invoices.created_at desc")
    .first
    .created_at
  end

  def revenue_subtotal
    invoice_items.sum("quantity * unit_price")/100.00
  end

  def revenue_grand_total
    if self.coupon.disc_type_before_type_cast == 0
      discount = coupon.disc_int/100.00
      total = revenue_subtotal - (revenue_subtotal * discount)
      total
    elsif self.coupon.disc_type_before_type_cast == 1
      discount = coupon.disc_int
      total = (revenue_subtotal - discount)
      if total <= 0
        total = 0
      else 
        total
      end
    end
  end

  def merchant_revenue_subtotal(merchant)
    self.items
        .where(merchant: merchant)
        .sum("invoice_items.unit_price * invoice_items.quantity")/100.00
  end

  def merchant_revenue_grand_total(merchant)
    if self.coupon.nil? || self.coupon.merchant != merchant
      merchant_revenue_subtotal(merchant)
    elsif self.coupon.disc_type_before_type_cast == 0 
      discount = coupon.disc_int/100.00
      total = merchant_revenue_subtotal(merchant) - (merchant_revenue_subtotal(merchant) * discount)
      total
    elsif self.coupon.disc_type_before_type_cast == 1
      discount = coupon.disc_int
      total = (merchant_revenue_subtotal(merchant) - discount)
      if total <= 0
        total = 0
      else 
        total
      end
    end
  end
end