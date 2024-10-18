# frozen_string_literal: true

When('I visit the profile page of another user') do
  @other_user = User.create!(first_name: 'Other', last_name: 'User', email: 'other@example.com')
  visit user_path(@other_user)
end

Then('I should see the user\'s profile information') do
  expect(page).to have_content(@other_user.first_name)
  expect(page).to have_content(@other_user.last_name)
  expect(page).to have_content(@other_user.email)
end

When('I visit my profile page') do
  click_link 'User Profile'
end

When('I am clicking on {string}') do |button_text|
  puts page.body
  find_button(button_text).click
end

When('I press button "Edit Profile"') do
  find('.edit-link').click
end

Then('I should be redirected to my profile page') do
  expect(current_path).to eq(user_path(@user))
end

Then('I should see my updated profile information') do
  expect(page).to have_content('Alice')
  expect(page).to have_content('Smith')
  expect(page).to have_content('alice.smith@example.com')
end

Then('I should see an error message') do
  expect(page).to have_content('error')
end

Then('I should still be on the edit profile page') do
  expect(current_path).to eq(edit_user_path(@user))
end
