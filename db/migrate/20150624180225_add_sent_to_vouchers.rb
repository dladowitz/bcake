class AddSentToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :sent, :datetime
  end
end
