require 'rails_helper'

RSpec.describe Client::Home::LoadMoreService, type: :service do

  subject { described_class.new(params_page) }

  15.times do
    brand = FactoryBot.create(:brand, title: Faker::Name.unique.name )
    product = FactoryBot.build(
      :product,
      brand_id: brand.id,
    )
    product.images.attach(io: File.open(Rails.root + "app/assets/images/home/products/men/men_1.jpg"), filename: "men_1.jpg")
    product.save
  end

  describe 'load more in product correct' do
    let!(:params_page) { 2 }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a correct format result' do
        expect(result[1]).to be nil
      end
    end
  end

  describe 'load more in product incorrect' do
    let!(:params_page) { rand(50..100) }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a incorrect format result' do
        expect(result[1]).to eq("error_page")
      end
    end
  end
end
