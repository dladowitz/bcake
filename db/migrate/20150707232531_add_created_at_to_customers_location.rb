class AddCreatedAtToCustomersLocation < ActiveRecord::Migration
  def change
    add_column :customers_locations, :created_at, :datetime
    add_column :customers_locations, :updated_at, :datetime

    time = Date.new(1970,01,01).to_time
    CustomersLocation.update_all(created_at: time, updated_at: time)
  end
end
