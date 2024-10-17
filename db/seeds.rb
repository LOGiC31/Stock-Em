# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Clear existing data to avoid duplication
Item.destroy_all
User.destroy_all

# Create Users
users = [
  { user_id: 'USR001', name: 'Philip Ritchey', uin: '123456', email: 'philip@example.com', contact_no: '5551234',
    role: 'professor_admin', auth_level: 2 },
  { user_id: 'USR002', name: 'Paul Taele', uin: '654321', email: 'paul@example.com', contact_no: '5555678',
    role: 'professor_admin', auth_level: 1 },
  { user_id: 'USR003', name: 'random TA', uin: '987654', email: 'randomTA@example.com', contact_no: '5559876',
    role: 'assistants', auth_level: 0 }
]

users.each { |user| User.create!(user) }

# Create Items
items = [
  { item_id: 'ITM001', serial_number: 'SN12345', item_name: 'ipad', category: 'Electronics', quality_score: 90,
    currently_available: true, details: 'some desc about the ipad.' },
  { item_id: 'ITM002', serial_number: 'SN54321', item_name: 'mobilePhonePixel', category: 'Electronics',
    quality_score: 85, currently_available: true },
  { item_id: 'ITM003', serial_number: 'SN67890', item_name: 'Desk Chair', category: 'Furniture', quality_score: 75,
    currently_available: false, details: 'comfy chair indeed!' },
  { item_id: 'ITM001', serial_number: 'SN12345', item_name: 'ipad', category: 'Electronics', quality_score: 90,
    currently_available: true, details: 'some desc about the ipad.' },
  { item_id: 'ITM002', serial_number: 'SN54321', item_name: 'mobilePhonePixel', category: 'Electronics',
    quality_score: 85, currently_available: true },
  { item_id: 'ITM003', serial_number: 'SN67890', item_name: 'Desk Chair', category: 'Furniture', quality_score: 75,
    currently_available: false, details: 'comfy chair indeed!' },
  { item_id: 'ITM001', serial_number: 'SN12345', item_name: 'ipad', category: 'Electronics', quality_score: 90,
    currently_available: true, details: 'some desc about the ipad.' },
  { item_id: 'ITM002', serial_number: 'SN54321', item_name: 'mobilePhonePixel', category: 'Electronics',
    quality_score: 85, currently_available: true },
  { item_id: 'ITM003', serial_number: 'SN67890', item_name: 'Desk Chair', category: 'Furniture', quality_score: 75,
    currently_available: false, details: 'comfy chair indeed!' },
  { item_id: 'ITM001', serial_number: 'SN12345', item_name: 'ipad', category: 'Electronics', quality_score: 90,
    currently_available: true, details: 'some desc about the ipad.' },
  { item_id: 'ITM002', serial_number: 'SN54321', item_name: 'mobilePhonePixel', category: 'Electronics',
    quality_score: 85, currently_available: true },
  { item_id: 'ITM003', serial_number: 'SN67890', item_name: 'Desk Chair', category: 'Furniture', quality_score: 75,
    currently_available: false, details: 'comfy chair indeed!' },
  { item_id: 'ITM001', serial_number: 'SN12345', item_name: 'ipad', category: 'Electronics', quality_score: 90,
    currently_available: true, details: 'some desc about the ipad.' },
  { item_id: 'ITM002', serial_number: 'SN54321', item_name: 'mobilePhonePixel', category: 'Electronics',
    quality_score: 85, currently_available: true },
  { item_id: 'ITM003', serial_number: 'SN67890', item_name: 'Desk Chair', category: 'Furniture', quality_score: 75,
    currently_available: false, details: 'comfy chair indeed!' },
    { item_id: 'ITM004', serial_number: 'SN11223', item_name: 'Laptop Dell XPS', category: 'Electronics', quality_score: 88, 
    currently_available: true, details: 'lightweight and powerful laptop.' },
  { item_id: 'ITM005', serial_number: 'SN44556', item_name: 'Projector', category: 'Electronics', quality_score: 80, 
    currently_available: false, details: 'high-resolution projection.' },
  { item_id: 'ITM006', serial_number: 'SN77889', item_name: 'Monitor LG', category: 'Electronics', quality_score: 82, 
    currently_available: true, details: '27-inch widescreen monitor.' },
  { item_id: 'ITM007', serial_number: 'SN99001', item_name: 'Graphics Tablet', category: 'Electronics', quality_score: 92, 
    currently_available: true, details: 'perfect for designers.' },
  { item_id: 'ITM008', serial_number: 'SN00234', item_name: 'Office Desk', category: 'Furniture', quality_score: 70, 
    currently_available: true, details: 'spacious office desk.' },
  { item_id: 'ITM009', serial_number: 'SN00987', item_name: 'Whiteboard', category: 'Supplies', quality_score: 65, 
    currently_available: false, details: 'magnetic whiteboard with markers.' },
  { item_id: 'ITM010', serial_number: 'SN33445', item_name: 'Bluetooth Speaker', category: 'Electronics', quality_score: 87, 
    currently_available: true, details: 'portable and powerful speaker.' },
  { item_id: 'ITM011', serial_number: 'SN66778', item_name: 'Mouse', category: 'Accessories', quality_score: 95, 
    currently_available: true, details: 'wireless ergonomic mouse.' },
  { item_id: 'ITM012', serial_number: 'SN99002', item_name: 'Keyboard', category: 'Accessories', quality_score: 85, 
    currently_available: false, details: 'mechanical keyboard for gaming.' }
]

items.each { |item| Item.create!(item) }

# # Create Notes
# notes = [
#   { note_id: 'NOTE001', item: Item.first, msg: 'ipad in good condition,
#          used for monitoring and cataloging.', user: User.first },
#   { note_id: 'NOTE002', item: Item.second, msg: 'android version recently updated.', user: User.second },
#   { note_id: 'NOTE003', item: Item.third, msg: 'Chair needs replacement, worn out fabric.', user: User.third }
# ]

# notes.each { |note| Note.create!(note) }

# # Create Events
# events = [
#   { item: Item.first, associated_user: User.first, associated_student: nil, created_at: DateTime.now,
#        updated_at: DateTime.now, event_type: 'checkedIn' },
#   { item: Item.second, associated_user: User.second, associated_student: nil, created_at: DateTime.now - 3.days,
#        updated_at: DateTime.now - 3.days, event_type: 'checkedIn' },
#   { item: Item.third, associated_user: User.third, associated_student: nil, created_at: DateTime.now - 5.days,
#        updated_at: DateTime.now - 5.days, event_type: 'relocated' }
# ]

# events.each { |event| Event.create!(event) }

puts 'Seed data loaded successfully!'
