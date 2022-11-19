class AddInOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :charge_id, :string
    add_column :orders, :error_message, :string
    add_column :orders, :payment_gateway, :integer
    add_money :orders, :price, currency: { present: false }
    add_reference :orders, :addresses, null: false, foreign_key: true
    remove_column :orders, :tax
    remove_column :orders, :promo
    remove_column :orders, :username
    remove_column :orders, :phone
    remove_column :orders, :email
    remove_column :orders, :gender
    remove_column :orders, :address
    remove_column :orders, :city
    remove_column :orders, :country
  end
end
