class Client::Home::ProductsSearchService < ApplicationService
  def initialize(search)
    @search = search
  end

  def call
    Product.query_search(:title, search).order(created_at: :desc)
  end

  private

  attr_accessor :search
end