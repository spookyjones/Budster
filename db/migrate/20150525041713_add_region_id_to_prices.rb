class AddRegionIdToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :region_id, :integer
    add_index :prices, :region_id
  end
end
