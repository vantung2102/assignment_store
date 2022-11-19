require 'rails_helper'

RSpec.describe Admin::Vouchers::CreateService, type: :service do

  subject { described_class.new(voucher_params) }

  let!(:voucher_params) { FactoryBot.attributes_for(:voucher) }

  describe '.call' do
    let!(:result) { subject.call }
    
    
    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[2]).to eq("Voucher was successfully created.")
    end
  end
end
