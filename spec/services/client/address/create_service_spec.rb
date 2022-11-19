require 'rails_helper'

RSpec.describe Client::Address::CreateService, type: :service do

  subject { described_class.new(address_params, user) }

  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }
  let!(:address_params) { FactoryBot.attributes_for(:address) }

  describe '.call' do
    let!(:result) { subject.call }
    
    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[2]).to eq("Address was successfully created.")
    end
  end
end
