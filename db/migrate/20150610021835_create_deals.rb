class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :birthday_deal
      t.string :monthly_deal
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
