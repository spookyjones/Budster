class AddStrainIdToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :strain_id, :integer
    add_index :regions, :strain_id
  end
end
