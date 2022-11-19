require 'rails_helper'

RSpec.describe UsersRole, type: :model do
  it { should belong_to(:user).without_validating_presence }
  it { should belong_to(:role).without_validating_presence }
end
