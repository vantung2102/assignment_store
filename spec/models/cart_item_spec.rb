require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it { should belong_to(:cart).without_validating_presence }
  it { should belong_to(:product).without_validating_presence }
end
