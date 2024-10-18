# frozen_string_literal: true

# Contains everything Note-related
class Note < ApplicationRecord
  belongs_to :item
  belongs_to :user

  def get_creator_name; end # rubocop:disable Naming/AccessorMethodName
end
