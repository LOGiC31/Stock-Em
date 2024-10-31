# frozen_string_literal: true

# app/models/admin.rb

class Admin < ApplicationRecord # rubocop:disable Style/Documentation
  has_secure_password

  validates :username, presence: true, uniqueness: true
end
