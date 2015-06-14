class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :token
      t.integer :customer_id
      t.integer :location_id
      t.datetime :redeemed

      t.timestamps null: false
    end
  end
end
