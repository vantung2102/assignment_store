require 'rails_helper'

RSpec.describe Admin::Products::CreateService, type: :service do

  subject { described_class.new(product_params) }

  let!(:brand) { FactoryBot.create(:brand) }
  let!(:params) { ActionController::Parameters.new(
    title: Faker::Name.name,
    meta_title: Faker::Name.name,
    content: Faker::Lorem.paragraph,
    quantity: rand(10..50),
    brand_id: brand.id,
    discount: rand(1..10.0) ,
    images: [Rack::Test::UploadedFile.new('spec/fixtures/girl_5.jpg', 'images/jpg')],
    product_attribute_1: ActionController::Parameters.new(
      name: "color",
      attribute_value: ActionController::Parameters.new(
        attribute: [Faker::Commerce.unique.color],
        price_attribute_product: [rand(10..100)],
        stock: [rand(10..100)],
      )
    ),
    product_attribute_2: ActionController::Parameters.new(
      name: "size",
      attribute_value: ActionController::Parameters.new(
        attribute: ['M'],
      )
    )
  ).permit(
      :title,
      :meta_title,
      :categories, 
      :content,
      :quantity,
      :brand_id,
      :price,
      :discount,
      images: [],
      category_ids: [],
      product_attribute_1: [
        :name,
        attribute_value: [
          attribute: [],
          price_attribute_product: [],
          stock: [],
        ],
        images: []
      ],
      product_attribute_2: [
        :name,
        attribute_value: [
          attribute: [],
        ]
      ],
      update: [
        :insert ,
        destroy: [
          attribute_value: []
        ]
      ]
    )
  }

  describe "No Attribute" do
    let!(:product_params) { params.except(:product_attribute_1, :product_attribute_2) }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a correct format result' do
        expect(result[0]).to be true
        expect(result[1]).to be_valid
      end
    end
  end
  
  describe "One Attribute" do
    let!(:product_params) { params.except(:product_attribute_2, :price, :quantity) }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a correct format result' do
        expect(result[0]).to be true
        expect(result[1]).to be_valid
      end
    end
  end

  describe "Two Attribute" do
    let!(:product_params) { params.except(:price, :quantity) }

    describe '.call' do
      let!(:result) { subject.call }

      it 'should have a correct format result' do
        expect(result[0]).to be true
        expect(result[1]).to be_valid
      end
    end
  end
end