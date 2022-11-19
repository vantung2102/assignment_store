require	'rails_helper'
include ControllerHelper

RSpec.describe Admin::VouchersController, type: :controller do
  let!(:vouchers) { Array.new(5) { FactoryBot.create(:voucher) } }
  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }

  before (:each) { allow(controller).to receive(:authorize_admin!).and_return(true) }

  describe "Index action" do
    subject { Voucher.all }

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
        expect(subject).to match_array(vouchers)
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
        login_admin_user(user)
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

  describe "Show action" do
    let!(:http) { 'get' }
    let!(:action) { :show }
    let!(:params) { { id: Voucher.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the show template" do
        get :show, params: { id: Voucher.first.id }
        expect(response).to render_template("show")
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Create action" do
    let!(:http) { 'post' }
    let!(:action) { :create }
    let!(:params) { { code: Faker::Lorem.word }}

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "create correct" do
        post :create, params: { 
          voucher: ActionController::Parameters.new(
            code: Faker::Code.nric,
            name: Faker::Name.name_with_middle,
            max_user: rand(100..200),
            type_voucher: Voucher.type_vouchers[:normal],
            discount_mount: rand(100..200),
            status: true,
            start_time: Faker::Date.in_date_period(month: 10),
            end_time: Faker::Date.in_date_period(month: 11) ,
            cost: rand(100..200),
            apply_amount: 0,
            description: Faker::Lorem.paragraph,
        ).permit(
          :code, :cost, :name, :max_user, :discount_mount, :apply_amount, :type_voucher, :status, :start_time, :end_time, :description
        ) 
      }
        expect(response).to redirect_to(admin_vouchers_path)
        expect(response).not_to render_template("new")
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Edit action" do
    let!(:http) { 'get' }
    let!(:action) { :edit }
    let!(:params) { { id: Voucher.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the edit template" do
        get :edit, params: { id: Voucher.first.id }
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
    let!(:params) { {  id: Voucher.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "render update" do
        post :update, params: {
          id: Voucher.first.id,
          voucher: ActionController::Parameters.new(
            code: Faker::Code.nric,
            name: Faker::Name.name_with_middle,
            max_user: rand(100..200),
            type_voucher: Voucher.type_vouchers[:normal],
            discount_mount: rand(100..200),
            status: true,
            start_time: Faker::Date.in_date_period(month: 10),
            end_time: Faker::Date.in_date_period(month: 11) ,
            cost: rand(100..200),
            apply_amount: 0,
            description: Faker::Lorem.paragraph,
          ).permit(
            :code, :cost, :name, :max_user, :discount_mount, :apply_amount, :type_voucher, :status, :start_time, :end_time, :description
          ) 
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
    let!(:params) { {  id: Voucher.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "destroy correct" do
        delete :destroy, params: { id: Voucher.first.id }
        expect(response).to redirect_to(admin_vouchers_url)
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end
end