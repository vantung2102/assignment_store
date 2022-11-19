class ChangeProductAttribute < ActiveRecord::Migration[6.1]
  def change
    add_column :product_attributes, :name, :string
  end
end
