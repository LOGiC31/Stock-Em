# frozen_string_literal: true

# Adds authorization data to users as a new col
class AddOauthDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string
  end
end
