Given('I am on the home page') do
    visit '/'
  end
  
  When('I click on {string}') do |button_text|
    click_button button_text
  end
  
  When('I successfully authenticate via Google') do
    # This is handled by OmniAuth mock configuration in env.rb
    visit '/auth/google_oauth2/callback'
  end
  
  When('I fail to authenticate via Google') do
    # Mock a failure in authentication
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  
    visit '/auth/google_oauth2/callback'
  end
  
  Then('I should be redirected to my user page') do
    expect(page).to have_current_path(user_path(User.last)) # Assuming the last created user is the logged-in one
  end
  
  Then('I should see {string}') do |message|
    expect(page).to have_content(message)
  end
  