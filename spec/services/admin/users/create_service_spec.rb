require 'rails_helper'

RSpec.describe Admin::Users::CreateService, type: :service do

  subject { described_class.new(user_params) }

  let!(:user_params) { FactoryBot.attributes_for(:user, email: Faker::Internet.email) }

  describe '.call' do
    let!(:result) { subject.call }
    
    
    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[2]).to eq("User was successfully created.")
    end
  end
end
