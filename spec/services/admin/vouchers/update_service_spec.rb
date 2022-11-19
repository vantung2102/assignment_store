require 'rails_helper'

RSpec.describe Admin::Vouchers::UpdateService, type: :service do

  subject { described_class.new(voucher, voucher_params) }

  let!(:voucher) { FactoryBot.create(:voucher) }
  let!(:voucher_params) { FactoryBot.attributes_for(:voucher) }

  describe '.call' do
    let!(:result) { subject.call }

    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("Voucher was successfully updated.")
    end
  end
end
