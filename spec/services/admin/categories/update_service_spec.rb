require 'rails_helper'

RSpec.describe Admin::Categories::DestroyService, type: :service do

  subject { described_class.new(category) }

  let!(:category) { FactoryBot.create(:category) }

  describe '.call' do
    let!(:result) { subject.call }

    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("Category was successfully destroy.")
    end
  end
end