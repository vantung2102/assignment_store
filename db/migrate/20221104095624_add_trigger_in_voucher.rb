class AddTriggerInVoucher < ActiveRecord::Migration[6.1]
  def self.up
    execute <<-SQL
      create trigger update_voucher
      before update on `vouchers`
      for each row
      begin
        if new.apply_amount > old.discount_mount then
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'your error message';
        end if;
      end;
    SQL
  end
end
