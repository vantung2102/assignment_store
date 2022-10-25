class ChangeOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :integer, :limit => 5
  end
end
