require	'rails_helper'

RSpec.describe AddressPolicy, type: :Policy do

	subject { described_class.new(user, address) }

  let(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }

  context 'Address of user' do
    let(:address) {[FactoryBot.create(:address, user_id: user.id)]}

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show_address) }
    it { is_expected.to permit_action(:change_address) }

    describe 'Update action' do
      let(:address) {FactoryBot.create(:address, user_id: user.id)}
      it { is_expected.to permit_action(:destroy) }
    end
    
    describe 'Update action' do
      let(:address) {FactoryBot.create(:address, user_id: user.id)}
      it { is_expected.to permit_action(:update) }
    end
  end

  context 'Address of not user' do
    let(:user_test) { FactoryBot.create(:user, email: Faker::Internet.email) }
    let(:address) { [FactoryBot.create(:address, user_id: user_test.id)] }

    it { is_expected.to forbid_actions(:index) }
    it { is_expected.to forbid_actions(:show_address) }
    it { is_expected.to forbid_actions(:change_address) }

    describe 'Update action' do
      let(:address) { FactoryBot.create(:address, user_id: user_test.id) }
      it { is_expected.to forbid_actions(:destroy) }
    end
    
    describe 'Update action' do
      let(:address) { FactoryBot.create(:address, user_id: user_test.id) }
      it { is_expected.to forbid_actions(:update) }
    end
  end
end
