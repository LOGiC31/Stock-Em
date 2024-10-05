# frozen_string_literal: true

# Contains everything User-related
class User < ApplicationRecord
  validates :email, presence: true
end
