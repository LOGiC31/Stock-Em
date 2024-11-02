# frozen_string_literal: true

# Creates a table to store admin users
class CreateAdmins < ActiveRecord::Migration[7.2]
  def change
    create_table :admins do |t|
      t.string :username, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    # Add a unique index to the username column
    add_index :admins, :username, unique: true
  end
end
