class AddAmountApplyingInVoucher < ActiveRecord::Migration[6.1]
  def change
    add_column :vouchers, :apply_amount, :integer
  end
end
