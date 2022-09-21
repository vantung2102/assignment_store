class AddSlugToBrands < ActiveRecord::Migration[6.1]
  def change
    add_column :brands, :slug, :string
  end
end
