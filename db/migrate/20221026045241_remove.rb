class Remove < ActiveRecord::Migration[6.1]
  def change
    remove_column :product_attributes, :attribute_product_title_id
    drop_table :attribute_product_titles
  end
end
