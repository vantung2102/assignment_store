require 'rails_helper'

RSpec.describe Client::Address::UpdateService, type: :service do

  subject { described_class.new(address, address_params) }
  
  user = FactoryBot.create(:user, email: Faker::Internet.email)

  let!(:address) { FactoryBot.create(:address, user_id: user.id)}
  let!(:address_params) { FactoryBot.attributes_for(:address, status: false).except(:user_id) }

  describe '.call' do
    let!(:result) { subject.call }
    
    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("Address was successfully updated.")
    end
  end
end
