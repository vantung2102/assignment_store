require 'rails_helper'

RSpec.describe Admin::Brands::UpdateService, type: :service do

  subject { described_class.new(brand, brand_params) }

  let!(:brand) { FactoryBot.create(:brand) }
  let!(:brand_params) { { title: Faker::Name.first_name  } }

  describe '.call' do
    let!(:result) { subject.call }

    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("Brand was successfully updated.")
    end
  end
end