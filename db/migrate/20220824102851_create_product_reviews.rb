class CreateProductReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :product_reviews do |t|
      t.string :title
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
