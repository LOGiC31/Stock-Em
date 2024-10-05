# frozen_string_literal: true

# Creates the Events database
class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :event_id
      t.references :item, null: false, foreign_key: true
      t.string :event_type
      t.references :associated_user, null: false, foreign_key: { to_table: :users }
      t.references :associated_student, foreign_key: { to_table: :users } # student might not be present for some events
      t.string :location
      t.string :details

      t.timestamps
    end
  end
end
