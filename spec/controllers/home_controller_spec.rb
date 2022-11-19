require	'rails_helper'

RSpec.describe HomeController, type: :controller do

  let!(:category) { FactoryBot.create(:category) }
  let!(:brand) { FactoryBot.create(:brand) }

  describe "GET index" do
    it "Page Home" do
      get :index
      expect(assigns(:categories)).to eq([category])
      expect(assigns(:brands)).to eq([brand])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "renders the caterogy" do
      get :index, params: { category: category.slug }
      expect(response).to render_template("index")
    end

    it "renders the brand" do
      get :index, params: { brand: brand.slug }
      expect(response).to render_template("index")
    end

    it "renders the page" do
      get :index, params: { page: rand(1..100) }
      expect(response).to render_template("index")
    end

    it "renders the search" do
      get :index, params: { search: Faker::Lorem.word }
      expect(response).to render_template("index")
    end
  end

  describe "GET change_category" do
    it "renders the caterogy" do
      get :change_category, params: { slug: category.slug }
      expect(response.status).to eq 200
    end
  end

  describe "GET change_brand" do
    it "renders the brand" do
      get :change_brand, params: { slug: brand.slug }
      expect(response.status).to eq 200
    end
  end

  describe "GET load_more_product" do
    it "renders the load more" do
      get :load_more_product, params: { page: rand(1..100) }
      expect(response.status).to eq 200
    end
  end

  describe "GET search" do
    it "renders the search" do
      get :search_product, params: { keyword: Faker::Lorem.word }
      expect(response.status).to eq 200
    end
  end
end