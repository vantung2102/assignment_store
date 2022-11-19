require 'rails_helper'

RSpec.describe Client::Home::ProductsBrandService, type: :service do

  subject { described_class.new(slug) }

  brand = FactoryBot.create(:brand, title: Faker::Name.unique.name )
  15.times do
    product = FactoryBot.build(
      :product,
      brand_id: brand.id,
    )
    product.images.attach(io: File.open(Rails.root + "app/assets/images/home/products/men/men_1.jpg"), filename: "men_1.jpg")
    product.save
  end

  describe 'get brand in product correct' do
    let!(:slug) { Brand.first.slug }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a correct format result' do
        expect(result).not_to be_empty
      end
    end
  end

  describe 'get brand in product incorrect' do
    brand = FactoryBot.create(:brand, title: Faker::Name.unique.name )
    let!(:slug) { brand.slug }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a incorrect format result' do
        expect(result).to be_empty
      end
    end
  end
end
