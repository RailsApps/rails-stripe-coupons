class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    yield resource if block_given?
    self.resource.coupon = Coupon.new
    respond_with self.resource
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation,
      :stripe_token, {coupon_attributes: [:code]})
  end

end
