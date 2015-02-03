class CreateCouponcodesService
  def call
    c1 = Coupon.where(code: '').first_or_initialize do |p|
      p.price = 995
    end
    c1.save!(:validate => false) if c1.new_record?
    c2 = Coupon.where(code: 'FREE').first_or_initialize do |p|
      p.price = 0
    end
    c2.save!(:validate => false) if c2.new_record?
    c3 = Coupon.where(code: 'HALFOFF').first_or_initialize do |p|
      p.price = 495
    end
    c3.save!(:validate => false) if c3.new_record?
  end
end
