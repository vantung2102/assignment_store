class CreateCategoryToCategories < ActiveRecord::Migration[6.1]
  def change
    add_reference :categories, :category, null: true, foreign_key: true
    
  end
end
