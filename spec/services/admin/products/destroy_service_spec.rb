require 'rails_helper'

RSpec.describe Admin::Products::DestroyService, type: :service do

  subject { described_class.new(product) }

  brand = FactoryBot.create(:brand)
  product = FactoryBot.build(:product, brand_id: brand.id)
  product.images.attach(io: File.open(Rails.root + "app/assets/images/home/products/men/men_1.jpg"), filename: "men_1.jpg")
  product.save

  let!(:product) { product }

  describe '.call' do
    let!(:result) { subject.call }

    it 'should have a correct format result' do
      expect(result[0]).to be true
      expect(result[1]).to eq("Product was successfully destroy.")
    end
  end
end