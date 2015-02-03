class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only

  respond_to :html

  def index
    @coupons = Coupon.all
    respond_with(@coupons)
  end

  def show
    respond_with(@coupon)
  end

  def new
    @coupon = Coupon.new
    respond_with(@coupon)
  end

  def edit
  end

  def create
    @coupon = Coupon.new(coupon_params)
    @coupon.save(validate: false)
    respond_with(@coupon)
  end

  def update
    @coupon = Coupon.find(params[:id])
    @coupon.attributes = coupon_params
    @coupon.save(validate: false)
    respond_with(@coupon)
  end

  def destroy
    @coupon.destroy
    respond_with(@coupon)
  end

  private
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      params.require(:coupon).permit(:code, :role, :mailing_list_id, :list_group, :price)
    end

    def admin_only
      unless current_user.admin?
        redirect_to root_path, :alert => "Access denied."
      end
    end

end
