require	'rails_helper'
include ControllerHelper

RSpec.describe Admin::UsersController, type: :controller do
  let!(:users) { Array.new(3) { FactoryBot.create(:user, email: Faker::Internet.unique.email) } }
  let!(:user) { User.first }

  before (:each) { allow(controller).to receive(:authorize_admin!).and_return(true) }

  describe "Index action" do
    subject { User.all }

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
        expect(subject).to match_array(users)
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
    let!(:params) { { id: User.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the show template" do
        get :show, params: { id: User.first.id }
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
    let!(:params) { }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "create correct" do
        post :create, params: { 
          user: ActionController::Parameters.new(
            name: Faker::Lorem.word,
            phone: '0984235062', 
            email: Faker::Internet.unique.email,
            password: 'Levantung123@',
            password_confirmation: 'Levantung123@',
          ).permit(
            :name, :phone, :gender, :email, :password, :password_confirmation, :avatar, :roles
          )
        }
        expect(response).to redirect_to(admin_users_path)
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
    let!(:params) { { id: User.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the edit template" do
        get :edit, params: { id: User.first.id }
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
    let!(:params) { {  id: User.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "render update" do
        post :update, params: {
          id: User.first.id,
          user: ActionController::Parameters.new(
            name: Faker::Lorem.word,
            phone: '0984235062', 
            email: Faker::Internet.unique.email,
            password: 'Levantung123@',
            password_confirmation: 'Levantung123@',
          ).permit(
            :name, :phone, :gender, :email, :password, :password_confirmation, :avatar, :roles
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
    let!(:params) { {  id: User.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "destroy correct" do
        delete :destroy, params: { id: User.first.id }
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end
end