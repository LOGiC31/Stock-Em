# frozen_string_literal: true

# Contains everything Item-related
class Item < ApplicationRecord
  validates :item_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :quality_score,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :serial_number, presence: true, uniqueness: true
  validates :category, inclusion: { in: %w[Electronics Furniture Accessories Supplies] }
  validates :currently_available, inclusion: { in: [true, false] }
  validates :location, length: { maximum: 100 }, allow_blank: true
end
