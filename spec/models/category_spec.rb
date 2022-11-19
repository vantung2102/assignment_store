require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:meta_title) }
  it { is_expected.to validate_presence_of(:content) }

  it { 
    should belong_to(:parent_category)
    .class_name('Category').with_foreign_key('category_id')
    .without_validating_presence 
  }
  it { should have_many(:child_category).class_name('Category') }

  it { should have_many(:product_categories) }
  it { should have_many(:products) }
end
