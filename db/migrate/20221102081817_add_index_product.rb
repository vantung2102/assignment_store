class AddIndexProduct < ActiveRecord::Migration[6.1]
  def change
    # add_index :products, :title, name: 'title_index_fulltext', type: :fulltext
    add_index :products, "to_tsvector('english', title)", using: :gin, name: "title_index_fulltext"
  end
end
