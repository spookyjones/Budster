class RemoveStrainIdFromRegions < ActiveRecord::Migration
  def change
    remove_column :regions, :strain_id, :integer
    remove_column :regions, :index, :string
  end
end
