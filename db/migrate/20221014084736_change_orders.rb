class ChangeOrders < ActiveRecord::Migration[6.1]
  def change
    # change_column :orders, :status, :integer, :limit => 5
    remove_column :orders, :status
    add_column :orders, :status, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
