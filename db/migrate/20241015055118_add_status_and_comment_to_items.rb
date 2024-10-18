# frozen_string_literal: true

class AddStatusAndCommentToItems < ActiveRecord::Migration[7.2] # rubocop:disable Style/Documentation
  def change
    add_column :items, :status, :string
    add_column :items, :comment, :text
  end
end
