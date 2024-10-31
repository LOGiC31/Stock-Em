Given('an admin with username {string} and password {string} exists') do |username, password|
  # Assuming you have an Admin model; adjust as necessary for your app's setup
  Admin.create(username:, password:)
end

Given('some users exists') do
  users = [
    { user_id: 'USR001', first_name: 'Philip', last_name: 'Ritchey', uin: '123456', email: 'philip@example.com', contact_no: '5551234',
      role: 'professor_admin', auth_level: 2 },
    { user_id: 'USR002', first_name: 'Paul', last_name: 'Taele', uin: '654321', email: 'paul@example.com', contact_no: '5555678',
      role: 'professor_admin', auth_level: 2 },
    { user_id: 'USR003', first_name: 'random', last_name: 'TA', uin: '987654', email: 'randomTA@example.com', contact_no: '5559876',
      role: 'assistants', auth_level: 1 }
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
