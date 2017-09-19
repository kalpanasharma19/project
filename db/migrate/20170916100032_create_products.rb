class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :stock_quantity
      t.attachment :image

      t.timestamps
    end
  end
end
