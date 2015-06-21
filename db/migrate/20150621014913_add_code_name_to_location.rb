class AddCodeNameToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :short_name, :string
    add_index :locations, :short_name
  end
end
