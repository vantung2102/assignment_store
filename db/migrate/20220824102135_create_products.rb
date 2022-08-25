class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :meta_title
      t.text :content
      t.string :slug
      t.float :price
      t.float :discount
      t.integer :quantity
      t.integer :type
      t.string :stock_keeping_unit

      t.timestamps
    end
  end
end
