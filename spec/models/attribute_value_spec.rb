require 'rails_helper'

RSpec.describe AttributeValue, type: :model do
  it { is_expected.to validate_presence_of(:price_attribute_product) }
  it { is_expected.to validate_presence_of(:stock) }

  it { should have_many(:product_attribute_values) }
  it { should have_many(:product_attributes) }
end
