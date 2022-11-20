class AddTriggerVochers < ActiveRecord::Migration[6.1]
  def self.up
    execute <<-SQL
      CREATE TRIGGER update_voucher
        BEFORE UPDATE ON vouchers
        FOR EACH ROW
        EXECUTE PROCEDURE log_last_name_changes();
    SQL
  end
end
