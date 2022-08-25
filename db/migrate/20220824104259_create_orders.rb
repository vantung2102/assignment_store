class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :session_id
      t.string :token
      t.string :status
      t.float :sub_total
      t.float :item_discount
      t.float :tax
      t.float :shipping
      t.float :total
      t.string :promo
      t.float :discount
      t.float :grand_total
      t.string :username
      t.string :phone
      t.string :email
      t.string :gender
      t.string :address
      t.string :city
      t.string :province
      t.string :country
      t.text :content

      t.timestamps
    end
  end
end
