require 'rails_helper'

RSpec.describe Admin::Vouchers::DestroyService, type: :service do

  subject { described_class.new(voucher) }

  let!(:voucher) { FactoryBot.create(:voucher) }

  describe '.call' do
    let!(:result) { subject.call }

    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("Voucher was successfully destroy.")
    end
  end
end