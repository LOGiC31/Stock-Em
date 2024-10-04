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