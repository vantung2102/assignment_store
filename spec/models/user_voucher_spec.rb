require 'rails_helper'

RSpec.describe UserVoucher, type: :model do
  it { should belong_to(:user).without_validating_presence }
  it { should belong_to(:voucher).without_validating_presence }
end
