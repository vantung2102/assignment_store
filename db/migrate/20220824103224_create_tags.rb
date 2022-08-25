class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :title
      t.string :meta_title
      t.string :slug
      t.text :content

      t.timestamps
    end
  end
end
