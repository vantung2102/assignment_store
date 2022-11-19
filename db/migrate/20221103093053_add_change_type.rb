class AddChangeType < ActiveRecord::Migration[6.1]
  def change
    rename_column :vouchers, :type, :type_voucher
  end
end
