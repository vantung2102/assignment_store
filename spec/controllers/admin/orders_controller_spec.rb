require	'rails_helper'
include ControllerHelper

RSpec.describe Admin::OrdersController, type: :controller do
  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }
  let!(:address) { FactoryBot.create(:address, user_id: user.id) }
  let!(:orders) { Array.new(5) { FactoryBot.create(:order, user_id: user.id, address_id: address.id) } }

  before (:each) { allow(controller).to receive(:authorize_admin!).and_return(true) }

  describe "Index action" do
    subject { Order.all }

    let!(:http) { 'get' }
    let!(:action) { :index }
    let!(:params) { }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the index template" do
        get :index
        expect(response).to render_template('index')
      end

      it "list data" do
        get :index
        expect(subject).to match_array(orders)
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Show action" do
    let!(:http) { 'get' }
    let!(:action) { :show }
    let!(:params) { { id: Order.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the show template" do
        get :show, params: { id: Order.first.id }
        expect(response).to render_template("show")
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Destroy action" do
    let!(:http) { 'delete' }
    let!(:action) { :destroy }
    let!(:params) { {  id: Order.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "destroy correct" do
        delete :destroy, params: { id: Order.first.id }
        expect(response).to redirect_to(admin_orders_url)
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Sumbit action" do
    let!(:http) { 'post' }
    let!(:action) { :submit }
    let!(:params) { {  id: Order.first.token } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "submit correct" do
        post :submit, params: { id: Order.first.token }

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq("successfully")
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Cancel action" do
    let!(:http) { 'post' }
    let!(:action) { :cancel }
    let!(:params) { {  id: Order.first.token } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "Cancel correct" do
        post :cancel, params: { id: Order.first.token }
        
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq("successfully")
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Success action" do
    let!(:http) { 'post' }
    let!(:action) { :success }
    let!(:params) { {  id: Order.first.token } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "Success correct" do
        post :success, params: { id: Order.first.token }
        
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['status']).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq("successfully")
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end
end