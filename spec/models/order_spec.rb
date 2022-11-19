require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many(:order_items) }

  it { should belong_to(:address).without_validating_presence }
  it { should belong_to(:user).without_validating_presence }
end
