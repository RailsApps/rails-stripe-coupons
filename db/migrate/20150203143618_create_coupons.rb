class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.string :role
      t.string :mailing_list_id
      t.string :list_group
      t.integer :price

      t.timestamps null: false
    end
  end
end
