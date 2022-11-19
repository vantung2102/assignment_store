require 'rails_helper'

RSpec.describe Voucher, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it "validates uniqueness of code" do
    subject { FactoryBot.build(:voucher, code: "ABC") }
    expect(subject).not_to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:max_user) }
  it { is_expected.to validate_presence_of(:type_voucher) }
  it { is_expected.to validate_presence_of(:discount_mount) }
  it { is_expected.to validate_presence_of(:apply_amount) }
  it { is_expected.to validate_presence_of(:cost) }
  it { is_expected.to validate_presence_of(:start_time) }
  it { is_expected.to validate_presence_of(:end_time) }

  it { should have_many(:user_vouchers) }
  it { should have_many(:users) }
  it { should have_many(:product_vouchers) }
  it { should have_many(:products) }
end
