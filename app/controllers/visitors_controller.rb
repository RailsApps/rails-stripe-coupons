class VisitorsController < ApplicationController

  def index
    @resource = User.new
    @resource.coupon = Coupon.new
  end

end
