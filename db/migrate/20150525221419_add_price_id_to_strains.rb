class AddPriceIdToStrains < ActiveRecord::Migration
  def change
    add_column :strains, :price_id, :integer
    add_index :strains, :price_id
  end
end
