class CreateAttributeProductTitle < ActiveRecord::Migration[6.1]
  def change
    create_table :attribute_product_titles do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
