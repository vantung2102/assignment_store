class AddAttributeValueInOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_items, :attribute_value, null: true, foreign_key: true
    add_reference :cart_items, :attribute_value, null: true, foreign_key: true
  end
end
