# frozen_string_literal: true

Given('I am on the item details page') do
  @item = Item.create(item_name: 'Lorem Ipsum Item', serial_number: '12345', category: 'Electronics',
                      quality_score: 55, currently_available: true)
  visit item_path(@item)
end

When('I fill in the field {string} with {string}') do |field_name, value|
  expect(page).to have_field(field_name, visible: true) # Ensure the field is visible
  fill_in(field_name, with: value)
end

Then('I should not see {string} in the item list') do |content|
  expect(page).not_to have_content(content)
end

When('I select {string}') do |action|
  button_mappings = {
    'Edit' => 'edit_button',
    'Back' => 'back_button',
    'Save' => 'submit_button',
    'Cancel' => 'cancel_button',
    'Delete' => 'delete_button'
  }

  button_id = button_mappings[action]
  raise "Unknown button action: #{action}" unless button_id

  page.find("##{button_id}", visible: :all, wait: 10).click
end

When('I set field {string} to {string}') do |field_label, new_value| # rubocop:disable Metrics/BlockLength
  # Remove colon from field label if present
  field_name = case field_label.gsub(':', '')
               when 'Item Name'
                 'item_name'
               when 'Quality Score'
                 'quality_score'
               when 'Category'
                 'category'
               when 'Status'
                 'internal_status'
               when 'Location'
                 'location'
               when 'Details'
                 'details'
               end

  begin
    case field_name
    when 'category', 'internal_status'
      # Handle hidden select fields differently
      select_element = find("select#item_#{field_name}", visible: :all)
      option = select_element.find(:option, new_value, visible: :all)
      option.select_option
    else
      # Handle regular input fields
      field = find("input#item_#{field_name}, textarea#item_#{field_name}", visible: :all)
      field.set(new_value)
    end
  rescue Capybara::ElementNotFound => e
    puts "\nAvailable fields:"
    all('input.editable, textarea.editable, select.editable', visible: :all).each do |f|
      puts "- #{f['id']}"
      next unless f.tag_name == 'select'

      puts '  Available options:'
      f.all('option', visible: :all).each do |opt|
        puts "    - #{opt.text}"
      end
    end
    raise e
  end
end
