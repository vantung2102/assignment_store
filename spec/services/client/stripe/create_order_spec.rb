require 'rails_helper'

RSpec.describe Client::Home::ProductsSearchService, type: :service do

  subject { described_class.new(charge) }

  brand = FactoryBot.create(:brand, title: Faker::Name.unique.name )

  describe 'get search in product correct' do
    let!(:search) { Product.first.title }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a correct format result' do
        expect(result).not_to be_empty
      end
    end
  end

  describe 'get search in product incorrect' do
    category = FactoryBot.create(:category, title: Faker::Name.unique.name )
    let!(:search) { Faker::Lorem.word }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a incorrect format result' do
        expect(result).to be_empty
      end
    end
  end
end
