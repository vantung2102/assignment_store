require 'rails_helper'

RSpec.describe ProductVoucher, type: :model do
  it { should belong_to(:voucher).without_validating_presence }
  it { should belong_to(:product).without_validating_presence }
end
