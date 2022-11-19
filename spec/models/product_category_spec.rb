require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  it { should belong_to(:category).without_validating_presence }
  it { should belong_to(:product).without_validating_presence }
end
