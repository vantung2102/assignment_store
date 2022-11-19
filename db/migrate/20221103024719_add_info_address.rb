class AddInfoAddress < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :province_id, :integer
    add_column :addresses, :district_id, :integer
    add_column :addresses, :ward_id, :integer
  end
end
