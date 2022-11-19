class AddPriceInProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :stripe_plan_name, :string
    add_column :products, :paypal_plan_name, :string
    add_money :products, :price, currency: { present: true }
  end
end
