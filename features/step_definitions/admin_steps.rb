# frozen_string_literal: true

Given('an admin with username {string} and password {string} exists') do |username, password|
  # Assuming you have an Admin model; adjust as necessary for your app's setup
  Admin.create(username:, password:)
end

Given('some users exists') do
  users = [
    {
      user_id: 'USR003',
      first_name: 'random',
      last_name: 'TA',
      uin: '987654',
      email: 'randomTA@example.com',
      contact_no: '5559876',
      role: 'assistants',
      auth_level: 1
    }
  ]

  users.each { |user| User.create!(user) }
end

When('I edit the user’s role to {string}') do |new_role|
  @user = User.find_by(user_id: 'USR003')
  # Locate the row for the user
  user_row = find("tr[data-user-id='#{@user.id}']")
  # Click edit button
  within(user_row) do
    find('.edit-button').click
  end
  # Select the new role
  within(user_row) do
    find('.auth-level-select').select(new_role)
  end
end

# When('I save the changes') do
#   @user = User.find_by(user_id: 'USR003')
#   user_row = find("tr[data-user-id='#{@user.id}']")
#   within(user_row) do
#     find('.save-button', visible: :visible, wait: 3).click
#   end
# end

Then('I should see the user’s role updated to {string}') do |updated_role|
  @user = User.find_by(user_id: 'USR003')
  @user.reload
  expect(@user.role).to eq(updated_role)

  user_row = find("tr[data-user-id='#{@user.id}']")
  within(user_row) do
    expect(page).to have_content(updated_role)
  end
end

Given('I see a user with auth level {string}') do |auth_level|
  expect(page).to have_content(auth_level)
end

When('I click the "Edit" button for that user') do
  # Assuming the edit button is the first one found for simplicity
  first('.edit-button').click
end

When('I change the auth level to {string}') do |new_auth_level|
  first('.auth-level-select').find(:option, new_auth_level).select_option
end

When('I click "Save"') do
  within('tr[data-user-id]') do
    # Check if the save button is visible and print the content of the row for debugging
    if page.has_selector?('.save-button', visible: true)
      find('.save-button').click
    else
      puts "Save button not found. Current row content: #{text}"
    end
  end
end

When('I click "Cancel"') do
  first('.cancel-button').click
end

Then('I should see the auth level updated to {string}') do |auth_level|
  expect(first('.auth-level-display')).to have_content(auth_level)
end

Then('I should see the user\'s role updated accordingly') do
  expect(first('td:nth-child(4)').text).not_to be_empty
end
