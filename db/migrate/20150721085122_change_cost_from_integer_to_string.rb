class ChangeCostFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :prices, :cost, :text
  end
end
