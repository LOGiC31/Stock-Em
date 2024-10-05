class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :item_id
      t.string :serial_number
      t.string :item_name
      t.string :category
      t.integer :quality_score
      t.boolean :currently_available
      t.string :image
      t.string :details

      t.timestamps
    end
  end
end
