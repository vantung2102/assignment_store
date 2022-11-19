class UpdateCart < ActiveRecord::Migration[6.1]
  def change
    remove_column :carts, :session_id
    remove_column :carts, :token
    remove_column :carts, :status
    remove_column :carts, :username
    remove_column :carts, :email
    remove_column :carts, :phone
    remove_column :carts, :gender
    remove_column :carts, :address
    remove_column :carts, :city
    remove_column :carts, :province
    remove_column :carts, :country

    remove_column :cart_items, :content
    remove_column :cart_items, :price
    remove_column :cart_items, :discount
    remove_column :cart_items, :active
  end
end
