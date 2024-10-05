# frozen_string_literal: true

# Creates the users database
class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :name
      t.string :uin
      t.string :email
      t.string :contact_no
      t.string :role
      t.string :details
      t.integer :auth_level
      t.timestamps
    end
  end
end
