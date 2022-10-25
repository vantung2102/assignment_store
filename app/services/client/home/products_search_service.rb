class Client::Home::ProductsSearchService < ApplicationService
  include UsersHelper

  def initialize(search)
    @search = search
  end

  def call
    Product.query_search(:title, search).order(created_at: :desc)
    # search([:Product], search)
  end

  private

  attr_accessor :search
end