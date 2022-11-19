class ChangeAttributeValue < ActiveRecord::Migration[6.1]
  def change
    add_column :attribute_values, :stock, :integer
    add_column :attribute_values, :attribute_1, :string
    add_column :attribute_values, :attribute_2, :string
  end
end
