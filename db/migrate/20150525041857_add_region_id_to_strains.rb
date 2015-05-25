class AddRegionIdToStrains < ActiveRecord::Migration
  def change
    add_column :strains, :region_id, :integer
    add_index :strains, :region_id
  end
end
