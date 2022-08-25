class AddProductToProductReviews < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_reviews, :product, null: false, foreign_key: true
    add_reference :product_reviews, :product_review, null: false, foreign_key: true
  end
end
