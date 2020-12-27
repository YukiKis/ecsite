class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :image_id, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.references :category, foreign_key: true
      t.integer :price, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
