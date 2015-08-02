class AddPostIdToStrain < ActiveRecord::Migration
  def change
    add_column :strains, :post_id, :integer
    add_index :strains, :post_id
  end
end
