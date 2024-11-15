# frozen_string_literal: true

When('I check the item database') do
  @items = Item.all
end

Then('I should see that {string} and {string} are present') do |item1, item2|
  item_names = @items.pluck(:item_name)
  expect(item_names).to include(item1)
  expect(item_names).to include(item2)
end

Then('there should be 1 item with serial number {string}') do |serial_number|
  item_count = Item.where(serial_number:).count
  expect(item_count).to eq(1)
end

When('I search for {string}') do |query|
  visit items_path(query:)
end

When('I filter by availability') do
  visit items_path(available_only: '1')
end

When('I search for {string} and filter by availability') do |query|
  visit items_path(query:, available_only: '1')
end

When('I fill in {string} with the sample import data') do |box|
  fill_in box, with: File.read('features/support/sample_import.txt')
end
