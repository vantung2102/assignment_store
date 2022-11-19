require 'rails_helper'

RSpec.describe Client::Product::CommentService, type: :service do

  subject { described_class.new(comment_params, user) }

  describe 'comment in product' do
    brand = FactoryBot.create(:brand)
    product = FactoryBot.build(
      :product,
      brand_id: brand.id,
    )
    product.images.attach(io: File.open(Rails.root + "app/assets/images/home/products/men/men_1.jpg"), filename: "men_1.jpg")
    product.save
    
    let!(:comment_params) { {
      slug: product.slug,
      content: Faker::Lorem.paragraph
    } }
    
    let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }

    describe '.call' do
      let!(:result) { subject.call }
      it 'should have a correct format result' do
        expect(result[0]).to be true
        expect(result[2]).to eq("Comment was successfully created.")
      end
    end
  end
end
