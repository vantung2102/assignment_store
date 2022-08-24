class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.string :stock_keeping_unit
      t.float :price
      t.float :discount
      t.integer :quantity
      t.boolean :active
      t.text :content

      t.timestamps
    end
  end
end
