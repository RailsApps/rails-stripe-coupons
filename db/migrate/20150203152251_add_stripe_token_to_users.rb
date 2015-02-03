class AddStripeTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_token, :string
  end
end
