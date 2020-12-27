class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false, foreign_key: true
      t.integer :order_item_id, null: false, foreign_key: true
      t.integer :payment, null: false
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :shipment, default: 800, null: false
      t.integer :total, null: false

      t.timestamps
    end
  end
end
