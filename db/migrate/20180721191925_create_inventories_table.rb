class CreateInventoriesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.references :product, foreign_key: true
      t.integer :waist
      t.integer :length
      t.string :style
      t.integer :count
      t.timestamps
    end
  end
end
