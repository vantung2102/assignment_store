require 'rails_helper'

RSpec.describe Client::Home::ProductsCategoryService, type: :service do

  subject { described_class.new(slug) }

  category = FactoryBot.create(:category, title: Faker::Name.unique.name )
  category = FactoryBot.create(:category, title: Faker::Name.unique.name )
  15.times do
    product = FactoryBot.build(:product, category_id: brand.id)
    product.images.attach(io: File.open(Rails.root + "app/assets/images/home/products/men/men_1.jpg"), filename: "men_1.jpg")
    product.save
    
    product.product_categories.create(category_id: category.id)
  end

  describe 'get category in product correct' do
    let!(:slug) { Category.first.slug }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a correct format result' do
        expect(result).not_to be_empty
      end
    end
  end

  describe 'get category in product incorrect' do
    category = FactoryBot.create(:category, title: Faker::Name.unique.name )
    let!(:slug) { category.slug }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a incorrect format result' do
        expect(result).to be_empty
      end
    end
  end
end
