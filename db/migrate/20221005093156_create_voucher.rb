class CreateVoucher < ActiveRecord::Migration[6.1]
  def change
    create_table :vouchers do |t|
      t.string :code
      t.string :name
      t.string :description
      t.integer :max_user
      t.integer :type, :limit => 5
      t.integer :discount_mount
      t.boolean :status
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
