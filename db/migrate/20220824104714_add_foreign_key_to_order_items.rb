class AddForeignKeyToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_items, :product, null: false, foreign_key: true
    add_reference :order_items, :order, null: false, foreign_key: true
  end
end
