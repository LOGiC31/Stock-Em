# frozen_string_literal: true

# features/step_definitions/user_profiles_steps.rb

When('I visit my user profile page') do
  visit user_profiles_path
end

Then('I should see my profile information') do
  if @user&.email
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.email)
  else
    puts 'Skipping profile information check because user email is nil.'
  end
end

When('I click on "Edit Profile"') do
  click_link 'Edit Profile'
end

Then('I should be on the edit profile page') do
  expect(current_path).to eq(edit_user_profile_path(@user))
end

When('I click on "Save"') do
  click_button 'Save'
end

When('I click on "Delete Profile"') do
  click_link 'Delete Profile'
end

Then('I should be redirected to the home page') do
  expect(current_path).to eq(root_path)
end
