require	'rails_helper'
include ControllerHelper

RSpec.describe Admin::BrandsController, type: :controller do
  let!(:brands) { Array.new(5) { FactoryBot.create(:brand) } }
  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }

  before (:each) { allow(controller).to receive(:authorize_admin!).and_return(true) }

  describe "Index action" do
    subject { Brand.all }

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
        expect(subject).to match_array(brands)
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
    let!(:params) { { id: Brand.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the show template" do
        get :show, params: { id: Brand.first.id }
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
    let!(:params) { { title: Faker::Lorem.word }}

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "create correct" do
        post :create, params: { 
          brand: ActionController::Parameters.new( title: Faker::Lorem.word ).permit(:title) 
        }
        expect(response).to redirect_to(admin_brands_path)
        expect(response).not_to render_template("new")
      end

      it "create incorrect" do
        get :create, params: { 
          brand: ActionController::Parameters.new( title: Brand.first.title ).permit(:title) 
        }
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
    let!(:params) { { id: Brand.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the edit template" do
        get :edit, params: { id: Brand.first.id }
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
    let!(:params) { {  id: Brand.first.id, title: Faker::Lorem.word } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "render update" do
        post :update, params: {
          id: Brand.first.id,
          brand: ActionController::Parameters.new( title: Faker::Lorem.word ).permit(:title) 
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
    let!(:params) { {  id: Brand.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "destroy correct" do
        delete :destroy, params: { id: Brand.first.id }
        expect(response).to redirect_to(admin_brands_url)
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end
end