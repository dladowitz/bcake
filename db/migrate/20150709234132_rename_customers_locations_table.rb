class RenameCustomersLocationsTable < ActiveRecord::Migration
  def self.up
     rename_table :customers_locations, :customer_signups
   end
   def self.down
     rename_table :customer_signups, :customers_locations
   end
end
