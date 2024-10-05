# frozen_string_literal: true

# Contains everything Note-related
class Note < ApplicationRecord
  belongs_to :item
  belongs_to :user
end
