class AddPositionToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :position, :integer
  end
end
