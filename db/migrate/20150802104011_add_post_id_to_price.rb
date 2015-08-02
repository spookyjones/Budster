class AddPostIdToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :post_id, :integer
    add_index :prices, :post_id
  end
end
