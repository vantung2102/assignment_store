require 'rails_helper'

RSpec.describe Admin::Brands::DestroyService, type: :service do

  subject { described_class.new(brand) }

  let!(:brand) { FactoryBot.create(:brand) }

  describe '.call' do
    let!(:result) { subject.call }

    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("Brand was successfully destroy.")
    end
  end
end