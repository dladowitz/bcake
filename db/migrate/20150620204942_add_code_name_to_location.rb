class AddCodeNameToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :codename, :string
  end
end
