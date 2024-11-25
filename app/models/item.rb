# frozen_string_literal: true

# Contains everything Item-related
class Item < ApplicationRecord
  has_many :notes, dependent: :destroy

  has_many :events, dependent: :destroy

  VALID_CATEGORIES = ['Mobile Devices',
                      'Development Boards and Kits',
                      'Sensors and Modules',
                      'Computer Accessories',
                      'Displays',
                      'Cables and Connectors',
                      'Miscellaneous Components and Kits', 'Furnitures', 'Electronics'].freeze
  validates :item_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :quality_score,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :serial_number, presence: true, uniqueness: true
  validates :category, inclusion: { in: VALID_CATEGORIES }
  validates :currently_available, inclusion: { in: [true, false] }

  require 'csv'
  def self.to_csv
    posts = all
    CSV.generate do |csv|
      csv << column_names
      posts.each do |post|
        csv << post.attributes.values_at(*column_names)
      end
    end
  end
end
