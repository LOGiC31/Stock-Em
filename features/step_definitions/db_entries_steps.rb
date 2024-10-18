# frozen_string_literal: true

Given(/the following items exist/) do |items_table|
  items_table.hashes.each do |item|
    Item.create item
  end
end

Given(/the following users exist/) do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Given(/the following notes exist/) do |notes_table|
  notes_table.hashes.each do |note|
    Note.create note
  end
end
