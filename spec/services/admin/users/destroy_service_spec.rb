require 'rails_helper'

RSpec.describe Admin::Users::DestroyService, type: :service do

  subject { described_class.new(user) }

  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }

  describe '.call' do
    let!(:result) { subject.call }

    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("User was successfully destroy.")
    end
  end
end