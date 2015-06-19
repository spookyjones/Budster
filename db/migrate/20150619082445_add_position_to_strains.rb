class AddPositionToStrains < ActiveRecord::Migration
  def change
    add_column :strains, :position, :integer
  end
end
