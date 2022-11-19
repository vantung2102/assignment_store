require	'rails_helper'
include ControllerHelper

RSpec.describe Admin::ProductsController, type: :controller do
  let!(:brand) { FactoryBot.create(:brand) }
  let!(:products) { Array.new(5) { FactoryBot.create(:product, brand_id: brand.id) } }
  let!(:user) { FactoryBot.create(:user, email: Faker::Internet.email) }
  let!(:product_params) { 
    ActionController::Parameters.new(
      title: Faker::Name.name,
      meta_title: Faker::Name.name,
      content: Faker::Lorem.paragraph,
      brand_id: brand.id,
      discount: rand(1..10.0) ,
      images: [
        Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/girl_5.jpg'))),
      ],
      product_attribute_1: ActionController::Parameters.new(
        name: "color",
        attribute_value: ActionController::Parameters.new(
          attribute: [Faker::Commerce.unique.color],
          price_attribute_product: [rand(20..100)],
          stock: [rand(10..100)],
        )
      ),
      product_attribute_2: ActionController::Parameters.new(
        name: "size",
        attribute_value: ActionController::Parameters.new(
          attribute: ['M'],
        )
      )
    ).permit(
        :title,
        :meta_title,
        :categories, 
        :content,
        :quantity,
        :brand_id,
        :price,
        :discount,
        images: [],
        category_ids: [],
        product_attribute_1: [
          :name,
          attribute_value: [
            attribute: [],
            price_attribute_product: [],
            stock: [],
          ],
          images: []
        ],
        product_attribute_2: [
          :name,
          attribute_value: [
            attribute: [],
          ]
        ],
        update: [
          :insert ,
          destroy: [
            attribute_value: []
          ]
        ]
      )
  }

  before (:each) { allow(controller).to receive(:authorize_admin!).and_return(true) }

  describe "Index action" do
    subject { Product.all }

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
        expect(subject).to match_array(products)
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
    let!(:params) { { id: Product.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the show template" do
        get :show, params: { id: Product.first.id }
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
        post :create, params: { product: product_params.except(:price, :quantity)}
        expect(response).to redirect_to(admin_products_path)
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
    let!(:params) { { id: Product.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "renders the edit template" do
        get :edit, params: { id: Product.first.id }
        expect(response).to render_template("edit")
      end
    end
    
    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end
  
  # describe "Update action" do
  #   let!(:http) { 'post' }
  #   let!(:action) { :update }
  #   let!(:params) { {  id: Product.first.id } }

  #   context "Logged in" do
  #     before :each do 
  #       login_admin_user(user)
  #     end
      
  #     it "render update" do
  #       post :update, params: {
  #         id: Product.first.id,
  #         product: ActionController::Parameters.new(
  #           code: Faker::Code.nric,
  #           name: Faker::Name.name_with_middle,
  #           max_user: rand(100..200),
  #           type_product: Product.type_products[:normal],
  #           discount_mount: rand(100..200),
  #           status: true,
  #           start_time: Faker::Date.in_date_period(month: 10),
  #           end_time: Faker::Date.in_date_period(month: 11) ,
  #           cost: rand(100..200),
  #           apply_amount: 0,
  #           description: Faker::Lorem.paragraph,
  #         ).permit(
  #           :code, :cost, :na#<Rack::Test::UploadedFile:0x0000563f38732918me, :max_user, :discount_mount, :apply_amount, :type_product, :status, :start_time, :end_time, :description
  #         ) 
  #       }
  #       expect(response).to render_template("edit")
  #     end
  #   end

  #   context "not logged in" do
  #     it_behaves_like "authenticate"
  #   end
  # end

  describe "Destroy action" do
    let!(:http) { 'delete' }
    let!(:action) { :destroy }
    let!(:params) { {  id: Product.first.id } }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "destroy correct" do
        delete :destroy, params: { id: Product.first.id }
        expect(response).to redirect_to(admin_products_url)
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "show_attribute action" do
    let!(:http) { 'post' }
    let!(:action) { :show_attribute }
    let!(:params) { }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "show_attribute correct" do
        delete :show_attribute, params: { id: Product.first.id }
        expect(JSON.parse(response.body)['status']).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('successfully')
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end

  describe "Destroy action" do
    let!(:http) { 'post' }
    let!(:action) { :show_attribute }
    let!(:params) { }

    context "Logged in" do
      before :each do 
        login_admin_user(user)
      end
      
      it "destroy correct" do
        delete :destroy, params: { id: Product.first.id }
        expect(response).to redirect_to(admin_products_url)
      end
    end

    context "not logged in" do
      it_behaves_like "authenticate"
    end
  end
end