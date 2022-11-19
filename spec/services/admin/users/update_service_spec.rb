require 'rails_helper'

RSpec.describe Admin::Users::UpdateService, type: :service do

  subject { described_class.new(user, user_params) }

  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }
  let!(:user_params) { FactoryBot.attributes_for(:user, email: Faker::Internet.email) }

  describe '.call' do
    let!(:result) { subject.call }

    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("User was successfully updated.")
    end
  end
end
