class AddTriggerInVoucher < ActiveRecord::Migration[6.1]
  def self.up
          # create trigger update_voucher
      # before update on `vouchers`
      # for each row
      # begin
      #   if new.apply_amount > old.discount_mount then
      #     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'your error message';
      #   end if;
      # end;
    execute <<-SQL
      CREATE OR REPLACE FUNCTION log_last_name_changes()
        RETURNS TRIGGER 
        LANGUAGE PLPGSQL
        AS
      $$
      BEGIN
        if new.apply_amount > old.discount_mount then
          RAISE EXCEPTION 'Invalid expiration date';
        end if;
      END;
      $$
    SQL
  end
end
