# frozen_string_literal: true

# features/step_definitions/create_item_steps.rb

Given("I am on the {string} page") do |page_name|
  visit new_item_path if page_name == "New Item"
end

When("I fill in the item field {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I select {string} from {string}") do |value, field|
  select value, from: field
end

When("I press the button {string}") do |button|
  save_and_open_page
  click_button button
end

Then("I should be on the {string} page") do |page_name|
  save_and_open_page
  expect(current_path).to eq(items_path) if page_name == "Items List"
  expect(current_path).to eq(new_item_path) if page_name == "New Item"
end

Then("I should see the message {string}") do |message|
  expect(page).to have_content(message)
end