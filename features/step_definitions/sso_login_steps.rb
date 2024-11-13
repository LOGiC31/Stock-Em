# frozen_string_literal: true

Given('I am on the home page') do
  visit '/'
end

When('I click on {string}') do |text|
  if has_link?(text)
    click_link(text, match: :prefer_exact)
  elsif has_button?(text)
    click_button text
  else
    raise "No button or link found with text '#{text}'"
  end
end

When('I successfully authenticate via Google') do
  visit '/auth/google_oauth2/callback'
end

When('I am an admin user') do
  @user = User.last
  @user.update!(auth_level: 2)
  puts @user.auth_level
end

When('I am an assistant user') do
  @user = User.last
  @user.update!(auth_level: 1)
  puts @user.auth_level
end

When('I fail to authenticate via Google') do
  OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

  visit '/auth/google_oauth2/callback'
end

Then('I should be redirected to my user page') do
  expect(page).to have_current_path(user_path(User.last))
end

Then('I should see {string}') do |message|
  expect(page).to have_content(message)
end

Then('I should be redirected to the welcome page') do
  expect(page).to have_current_path(welcome_path)
end

When('I visit the home page') do
  visit root_path # Adjust this if your home path is different
end

When('I visit the items page') do
  visit '/items'
end
