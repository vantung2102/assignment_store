class CreateAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :fullname
      t.string :phone_number
      t.integer :province_id
      t.integer :district_id
      t.integer :ward_id
      t.text :addressDetail
      t.boolean :status, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
