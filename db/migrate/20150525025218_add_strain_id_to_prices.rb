class AddStrainIdToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :strain_id, :integer
    add_index :prices, :strain_id
  end
end
