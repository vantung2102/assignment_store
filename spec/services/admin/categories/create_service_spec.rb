require 'rails_helper'

RSpec.describe Admin::Categories::CreateService, type: :service do

  subject { described_class.new(category_params) }

  let!(:category_params) { FactoryBot.attributes_for(:category) }

  describe '.call' do
    let!(:result) { subject.call }
    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[2]).to eq("Category was successfully created.")
    end
  end
end
