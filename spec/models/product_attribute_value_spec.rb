require 'rails_helper'

RSpec.describe ProductAttributeValue, type: :model do
  it { should belong_to(:product_attribute).without_validating_presence }
  it { should belong_to(:attribute_value).without_validating_presence }
end
