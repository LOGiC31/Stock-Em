Given('I am on the home page') do
    visit '/'
  end

  When('I click on {string}') do |button_text|
    click_button button_text
  end

  When('I successfully authenticate via Google') do
    visit '/auth/google_oauth2/callback'
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