require 'rails_helper'

RSpec.describe ProductAttribute, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { should have_many(:product_attribute_values) }
  it { should have_many(:attribute_values) }
  it { should have_many_attached(:images) }

  it { should belong_to(:product).without_validating_presence }
end
