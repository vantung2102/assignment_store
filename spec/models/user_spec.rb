require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to validate_presence_of(:email) }
  it "validates uniqueness of email" do
    subject { FactoryBot.build(:user, email: "vantung21022@gmail.com") }
    expect(subject).not_to be_valid
  end

  it { should have_many(:comments) }
  it { should have_many(:addresses) }
  it { should have_many(:user_vouchers) }
  it { should have_many(:vouchers) }
  it { should have_many(:vouchers) }
  it { should have_many(:orders) }
  it { should have_one(:cart) }
  it { should have_one_attached(:avatar) }

end

RSpec.describe PasswordValidator, type: :model do
  subject { FactoryBot.build(:user, email: Faker::Internet.email) }

  context 'password' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end

RSpec.describe PhoneNumberValidator, type: :model do
  subject { FactoryBot.build(:user, email: Faker::Internet.email) }

  context 'phone' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end