class AddIndexProduct < ActiveRecord::Migration[6.1]
  def change
    add_index :products, :title, name: 'title_index_fulltext', type: :fulltext
  end
end
