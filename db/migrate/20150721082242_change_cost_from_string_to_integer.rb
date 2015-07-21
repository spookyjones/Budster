class ChangeCostFromStringToInteger < ActiveRecord::Migration
  def change
    change_column :prices, :cost, 'integer USING CAST(cost AS integer)'
  end
end
