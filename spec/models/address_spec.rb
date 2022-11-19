require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to validate_presence_of(:fullname) }
  it { is_expected.to validate_presence_of(:phone_number) }
  it { is_expected.to validate_presence_of(:province) }
  it { is_expected.to validate_presence_of(:district) }
  it { is_expected.to validate_presence_of(:addressDetail) }
  it { is_expected.to validate_presence_of(:province_id) }
  it { is_expected.to validate_presence_of(:district_id) }

  it { should belong_to(:user).without_validating_presence }
  it { should have_many(:orders) }
end
