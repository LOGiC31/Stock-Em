# frozen_string_literal: true

Given('there is an item in the database') do
  @item = Item.create!(
    serial_number: '123456',
    item_name: 'Sample Item',
    category: 'Electronics',
    quality_score: 5,
    currently_available: true,
    image: nil,
    details: 'This is a sample item for testing purposes.'
  )
end

When('I visit the item page') do
  visit item_path(@item)
end

Then("I should see the item's details") do
  expect(page).to have_content(@item.serial_number)
  expect(page).to have_content(@item.item_name)
  expect(page).to have_content(@item.category)
  expect(page).to have_content(@item.quality_score)
  expect(page).to have_content(@item.details)
  expect(page).to have_content(@item.currently_available ? 'Available' : 'Not Available')
end

Given('I have an item named {string} with status {string}') do |item_name, status|
  @item1 = Item.find_or_create_by(item_name:)
  @item1.update(status:)
end

When('I select {string} from the status dropdown') do |status|
  select status, from: 'item[status]' # Ensure the select element has this name
end

Then('the item status should be {string}') do |expected_status|
  @item.reload # Reload the item from the database
  if expected_status == 'nil'
    expect(@item.status).to be_nil
  else
    expect(@item.status).to eq(expected_status)
  end
end

When('I filter by status {string}') do |status|
  within('#status') do
    find('#status').click
    find('option', text: status).click
  end
  click_button 'Filter'
end

When('I click on the status dropdown') do
  puts "Current URL: #{current_path}"
  find('.status').click
end

When('I click on the category dropdown') do
  puts "Current URL: #{current_path}"
  find('.category').click
end

When('I select {string} from the status dropdown list') do |status|
  select status, from: 'status'
  selected_option = find('#status option[selected]')
  expect(selected_option.text).to eq(status.capitalize)
end

When('I select {string} from the category dropdown list') do |category|
  select category, from: 'category'
  selected_option = find('#category option[selected]')
  expect(selected_option.text).to eq(category)
end

When('I click Filter') do
  button = find('input.btn.btn-primary[type="submit"]')
  button.click
end

