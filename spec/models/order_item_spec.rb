require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:product).without_validating_presence }
  it { should belong_to(:order).without_validating_presence }
  it { should belong_to(:attribute_value).without_validating_presence }
end
