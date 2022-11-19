require	'rails_helper'

RSpec.describe UserPolicy, type: :Policy do

	subject { described_class.new(user, brand) }

  let(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }
  let(:brand) { FactoryBot.create(:brand) }

 
  context 'being a visitor' do
    before :each do 
      user.add_role :user
    end

    it { is_expected.to forbid_all_actions }
  end

  context 'being an administrator' do
    before :each do 
      user.add_role :admin
    end

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:update) }
  end
end
