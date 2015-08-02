class AddPostIdToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :post_id, :integer
    add_index :regions, :post_id
  end
end
