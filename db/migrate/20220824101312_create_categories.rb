class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :meta_title
      t.string :slug
      t.string :content

      t.timestamps
    end
  end
end
