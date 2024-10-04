# frozen_string_literal: true

Given('I am logged in') do
  visit '/auth/google_oauth2/callback'
end

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When('I fill in {string} with {string}') do |field, value|
  fill_in(field, with: value)
end

When('I press {string}') do |button|
  click_button(button)
end

When('I follow {string}') do |link|
  click_link(link)
end

#Then('I should see {string}') do |string|
#  expect(page).to have_content(string)
#end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end
