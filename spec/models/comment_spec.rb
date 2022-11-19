require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of(:content) }
  it { 
    is_expected.to validate_length_of(:content).is_at_most(500).is_at_least(6)
  }

  it { 
    should belong_to(:parent_comment)
    .class_name('Comment').with_foreign_key('comment_id')
    .without_validating_presence 
  }
  it { should have_many(:child_comment).class_name('Comment') }

  it { should belong_to(:product).without_validating_presence }
  it { should belong_to(:user).without_validating_presence }
end
