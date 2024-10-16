class AddStatusAndCommentToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :status, :string
    add_column :items, :comment, :text
  end
end
