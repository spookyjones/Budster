class AddHomeLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_location, :string
  end
end
