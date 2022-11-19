require 'rails_helper'

RSpec.describe Admin::Brands::CreateService, type: :service do

  subject { described_class.new(brand_params) }

  let!(:brand_params) { { title: Faker::Name.first_name  } }

  describe '.call' do
    let!(:result) { subject.call }
    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[2]).to eq("Brand was successfully created.")
    end
  end
end