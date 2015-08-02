class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.references :user, index: true, foreign_key: true
      t.references :price, index: true, foreign_key: true
      t.references :strain, index: true, foreign_key: true
      t.references :region, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
