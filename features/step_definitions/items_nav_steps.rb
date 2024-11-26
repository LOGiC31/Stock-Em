# frozen_string_literal: true

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

Given('I am on the edit notes page for the item {string}') do |serial_number|
  item = Item.find_by(serial_number:)
  visit item_path(item, writing_note: true)
end

Then('I should be on the home page') do
  expect(page).to have_current_path(items_path)
end

When('I add and submit a file') do
  page.attach_file('file', Rails.root + 'features/support/sample_import.csv')
  Capybara.ignore_hidden_elements = false
  click_button('PublishImportItemsASD')
end