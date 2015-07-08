class AddIdToCustomerLocations < ActiveRecord::Migration
  def self.up
    add_column :customers_locations, :id, :primary_key
  end

  def self.down
    remove_column :customers_locations, :id
  end
end
