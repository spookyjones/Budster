class AddRatingToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :rating, :integer
  end
end
