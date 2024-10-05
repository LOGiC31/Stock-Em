# frozen_string_literal: true


#Given(/the following items exist/) do |items_table|
#  items_table.hashes.each do |item|
#    Item.create item
#  end
#end

Then(/I should see all the items/) do
  Item.all.find_each do |item|
    step %(I should see "#{item.title}")
  end
end

Given('I am on the items home page') do
  visit items_path
end

Given('I am on the details page for the item {string}') do |serial_number|
  item = Item.find_by(serial_number:)
  visit item_path(item)
end

Then('I should be on the home page') do
  expect(page).to have_current_path(items_path)
end