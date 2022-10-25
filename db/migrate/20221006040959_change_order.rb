class ChangeOrder < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :addresses_id, :address_id
  end
end
