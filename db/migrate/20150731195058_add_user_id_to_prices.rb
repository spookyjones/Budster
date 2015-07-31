class AddUserIdToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :user_id, :integer
    add_index :prices, :user_id
  end
end
