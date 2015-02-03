class AddCouponRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :coupon, index: true
    add_foreign_key :users, :coupons
  end
end
