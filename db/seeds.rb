# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Clear existing data to avoid duplication

# Create Users
Admin.find_or_create_by(username: 'admin') do |admin|
  admin.password = 'admin' # Raw password
end

puts 'Seed data loaded successfully!'
