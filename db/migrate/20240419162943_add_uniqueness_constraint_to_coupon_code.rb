class AddUniquenessConstraintToCouponCode < ActiveRecord::Migration[7.1]
  def change
    add_index :coupons, :code, unique: true
  end
end
