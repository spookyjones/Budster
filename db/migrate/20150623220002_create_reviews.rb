class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :review
      t.integer :price_id

      t.timestamps null: false
    end
    add_index :reviews, :price_id
  end
end
