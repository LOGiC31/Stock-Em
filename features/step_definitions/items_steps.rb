# frozen_string_literal: true

Given('the following items exist:') do |table|
  table.hashes.each do |item|
    Item.create!(
      item_name: item['item_name'],
      serial_number: item['serial_number'],
      category: item['category'],
      quality_score: item['quality_score'].to_i,
      currently_available: item['currently_available'] == 'true'
    )
  end
end

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
