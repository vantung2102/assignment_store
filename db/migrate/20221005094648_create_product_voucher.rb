class CreateProductVoucher < ActiveRecord::Migration[6.1]
  def change
    create_table :product_vouchers do |t|
      t.references :voucher, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false

      t.timestamps
    end
  end
end
