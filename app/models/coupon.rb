class Coupon < ApplicationRecord
  has_many :users
  validates :code, inclusion: { in: Coupon.pluck('DISTINCT code'),
      message: "value is not a valid coupon code" }
end
