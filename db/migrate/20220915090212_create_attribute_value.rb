class CreateAttributeValue < ActiveRecord::Migration[6.1]
  def change
    create_table :attribute_values do |t|
      t.references :product_attribute, null: false, foreign_key: true
      t.string :value
      t.float :price_attribute_product

      t.timestamps
    end
  end
end
