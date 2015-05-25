class RemoveRegionIdFromStrains < ActiveRecord::Migration
  def change
    remove_column :strains, :region_id
  end
end
