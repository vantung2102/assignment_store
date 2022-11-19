class CreateProductAttributeValue < ActiveRecord::Migration[6.1]
  def change
    remove_column :attribute_values, :product_attribute_id

    create_table :product_attribute_values do |t|
      t.references :product_attribute, null: false, foreign_key: true
      t.references :attribute_value, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
