class AddAveragePriceToRegions < ActiveRecord::Migration
  def change
  	add_column :strains, :average_price, :float, :default => 0, :null => false
    add_index :strains, :average_price
  end
end