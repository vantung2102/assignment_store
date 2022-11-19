require	'rails_helper'
include ControllerHelper

RSpec.describe Admin::CategoriesController, type: :controller do
  let!(:categories) { Array.new(5) { FactoryBot.create(:category) } }
  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }

  before (:each) { allow(controller).to receive(:authorize_admin!).and_return(true) }

  describe "Index action" do
    subject { Category.all }

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
        expect(subject).to match_array(categories)
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
    let!(:params) { { id: Category.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the show template" do
        get :show, params: { id: Category.first.id }
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
          category: ActionController::Parameters.new(
          title: Faker::Lorem.word,
          meta_title: Faker::Lorem.word,
          content: Faker::Lorem.word,
        ).permit(
          :title,
          :meta_title,
          :content,
          :category_id
        ) 
      }
        expect(response).to redirect_to(admin_categories_path)
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
    let!(:params) { { id: Category.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the edit template" do
        get :edit, params: { id: Category.first.id }
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
    let!(:params) { {  id: Category.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "render update" do
        post :update, params: {
          id: Category.first.id,
          category: ActionController::Parameters.new(
            title: Faker::Lorem.word,
            meta_title: Faker::Lorem.word,
            content: Faker::Lorem.word,
          ).permit(
            :title,
            :meta_title,
            :content,
            :category_id
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
    let!(:params) { {  id: Category.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "destroy correct" do
        delete :destroy, params: { id: Category.first.id }
        expect(response).to redirect_to(admin_categories_url)
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end
end