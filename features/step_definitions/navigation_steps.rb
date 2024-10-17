# frozen_string_literal: true

Given('I am logged in') do
  visit '/auth/google_oauth2/callback'
end

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2))
end


When('I press {string}') do |button|
  click_button(button)
end

When('I follow {string}') do |link|
  click_link(link)
end

# Then('I should see {string}') do |string|
#  expect(page).to have_content(string)
# end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end
