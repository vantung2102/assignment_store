require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:meta_title) }
  it { is_expected.to validate_presence_of(:content) }

  it { is_expected.to validate_presence_of(:images) }
  it { is_expected.to validate_presence_of(:discount) }
  it { should validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }

  it { should validate_numericality_of(:price) }

  context "if quantity?" do
    before { allow(subject).to receive(:quantity?).and_return(true) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end


  it { should belong_to(:brand).without_validating_presence }

  it { should have_many(:product_categories) }
  it { should have_many(:categories) }
  it { should have_many(:comments) }
  it { should have_many(:product_attributes) }
  it { should have_many(:product_vouchers) }
  it { should have_many(:vouchers) }
  it { should have_many(:cart_items) }
  it { should have_many(:order_items) }
  it { should have_many_attached(:images) }
end
