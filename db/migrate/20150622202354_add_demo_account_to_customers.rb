class AddDemoAccountToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :demo_account, :boolean
  end
end
