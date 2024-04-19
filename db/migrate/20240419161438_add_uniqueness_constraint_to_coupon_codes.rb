class AddUniquenessConstraintToCouponCodes < ActiveRecord::Migration[7.1]
  def change
    add_index :coupons, [:code, :merchant_id], unique: true
  end
end
