# require 'rails_helper'

# RSpec.describe Client::Address::UpdateService, type: :service do

#   subject { described_class.new(carts_json, user) }

#   let!(:carts_json) { Address.first.nil? ? FactoryBot.create(:address) : Address.first }
#   let!(:user) { FactoryBot.attributes_for(:address, province: Faker::Name.name, district: Faker::Name.name,status: false).except(:user_id) }

#   describe '.call' do
#     let!(:result) { subject.call }
    
#     it 'should have a correct format result' do
#       expect(result[0]).to be true
#       expect(result[1]).to eq("Address was successfully updated.")
#     end
#   end
# end
