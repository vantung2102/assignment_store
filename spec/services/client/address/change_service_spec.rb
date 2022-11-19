require 'rails_helper'

RSpec.describe Client::Address::ChangeService, type: :service do

  subject { described_class.new(change_address_params, user) }

  describe 'change address' do
    user = FactoryBot.create(:user, email: Faker::Internet.email)
    FactoryBot.create(:address, user_id: user.id, status: true)
    address = FactoryBot.create(:address, user_id: user.id, status: false)

    let!(:user) { user }
    let!(:change_address_params) { address.id }

    describe '.call' do
      let!(:result) { subject.call }
      
      it 'should have a correct format result' do
        expect(result).to be true
      end
    end
  end
end
