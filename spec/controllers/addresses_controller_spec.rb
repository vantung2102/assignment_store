require	'rails_helper'
include ControllerHelper

RSpec.describe AddressesController, type:	:controller do
  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }
  let!(:addresses) { Array.new(5) { FactoryBot.create(:address, user_id: user.id) }}

  let(:user_test) { FactoryBot.create(:user, email: Faker::Internet.email) }
  let(:address_test) { FactoryBot.create(:address, user_id: user_test.id) }

  describe "Index action" do
    subject { Address.where(user_id: user.id) }

    let!(:http) { 'get' }
    let!(:action) { :index }
    let!(:params) { }

    context "Logged in" do
      before :each do 
        login_client_user(user)
      end
      
      it "renders the index template" do
        get :index
        expect(response).to render_template('index')
      end

      it "list data" do
        get :index
        expect(subject).to match_array(addresses)
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "show_address action" do
    subject { Address.where(user_id: user.id) }

    let!(:http) { 'post' }
    let!(:action) { :show_address }
    let!(:params) { }

    context "Logged in" do
      before :each do 
        login_client_user(user)
      end
      
      it "renders the index template" do
        post :show_address
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('successfully')
      end

      it "list data" do
        post :show_address
        expect(subject).to match_array(addresses)
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "New action" do
    let!(:http) { 'get' }
    let!(:action) { :new }
    let!(:params) { }

    context "Logged in" do
      before :each do 
        login_client_user(user)
      end
      
      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Create action" do
    let!(:http) { 'post' }
    let!(:action) { :create }
    let!(:params) { { title: Faker::Lorem.word } }

    context "Logged in" do
      before :each do 
        login_client_user(user)
      end
      
      it "create correct" do
        post :create, params: { 
          address: ActionController::Parameters.new(
            fullname: Faker::Name.name,
            phone_number: '0984235062',
            addressDetail: '85/23c KDC Dai Hai',
            user_id: user.id,
            status: false,
            province: 'TP.Hồ Chí Minh',
            province_id: 202,
            district: 'Quận 10',
            district_id: 1452,
            ward: 'Phường 3',
            ward_id: 21003,
          ).permit(
            :fullname,
            :phone_number,
            :province_id,
            :province,
            :district_id,
            :district,
            :ward_id,
            :ward,
            :addressDetail,
          ) 
        }
        expect(response).to redirect_to(user_addresses_path)
        expect(response).not_to render_template("new")
      end

      it "create incorrect" do
        get :create, params: {  brand: nil }
        expect(response).to render_template("new")
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Edit action" do
    let!(:http) { 'get' }
    let!(:action) { :edit }
    let!(:params) { { id: Address.first.id } }

    context "Logged in" do
      before :each do 
        login_client_user(user)
      end
      
      it "renders the edit template" do
        get :edit, params: { id: Address.first.id }
        expect(response).to render_template("edit")
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Update action" do
    let!(:http) { 'post' }
    let!(:action) { :update }
    let!(:params) { {  id: Address.first.id, fullname: Faker::Lorem.word } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "render update" do
        post :update, params: {
          id: Address.first.id,
          address: ActionController::Parameters.new(
            fullname: Faker::Lorem.word 
          ).permit(:fullname) 
        }
        expect(response).to render_template("edit")
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Destroy action" do
    let!(:http) { 'delete' }
    let!(:action) { :destroy }
    let!(:params) { {  id: Address.first.id } }

    context "Logged in" do
      before :each do 
        login_client_user(user)
      end
      
      it "destroy correct" do
        delete :destroy, params: { id: Address.first.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Successfully')
      end

      it "destroy incorrect" do
        delete :destroy, params: { id: 100 }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq(500)
        expect(JSON.parse(response.body)['message']).to eq('error')
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "change_address action" do
    let!(:http) { 'post' }
    let!(:action) { :change_address }
    let!(:params) { {  change_address: Address.first.id } }

    context "Logged in" do
      before :each do 
        login_client_user(user)
      end
      
      it "change_address correct" do
        post :change_address, params: { change_address: Address.first.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Successfully')
      end

      it "destroy incorrect" do
        post :change_address, params: { change_address: 100 }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq(500)
        expect(JSON.parse(response.body)['message']).to eq('error')
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end
end