require 'rails_helper'
include ActiveModel::Model

RSpec.describe Brand, type: :model do
  it { is_expected.to validate_presence_of(:title) }

  it "validates uniqueness of title" do
    brand = FactoryBot.create(:brand, title: 'Apple')
    brand_test = FactoryBot.build(:brand, title: 'Apple')
    
    expect(brand_test).not_to be_valid
  end

  it { should have_many(:products) }
end
