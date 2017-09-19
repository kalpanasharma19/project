class CreateDeliveryAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_addresses do |t|
      t.string :name
      t.text :address
      t.text :phone_number
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
