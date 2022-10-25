class AddCostInVoucher < ActiveRecord::Migration[6.1]
  def change
    add_column :vouchers, :cost, :float
  end
end
