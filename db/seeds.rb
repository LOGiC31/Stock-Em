# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Clear existing data to avoid duplication

# Create Users
users = [
  { user_id: 'USR001', name: 'Philip Ritchey', uin: '123456', email: 'philip@example.com', contact_no: '5551234',
    role: 'professor_admin', auth_level: 2 },
  { user_id: 'USR002', name: 'Paul Taele', uin: '654321', email: 'paul@example.com', contact_no: '5555678',
    role: 'professor_admin', auth_level: 2 },
  { user_id: 'USR003', name: 'random TA', uin: '987654', email: 'randomTA@example.com', contact_no: '5559876',
    role: 'assistants', auth_level: 1 }
]

users.each { |user| User.create!(user) }

Admin.find_or_create_by(username: 'admin') do |admin|
  admin.password = 'admin' # Raw password
end

puts 'Seed data loaded successfully!'
