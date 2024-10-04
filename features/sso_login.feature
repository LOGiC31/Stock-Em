Feature: SSO Login
  As a user
  I want to log in using SSO
  So that I can securely access the application

  Scenario: Successful login via Google OAuth
    Given I am on the home page
    When I click on "Login with Google"
    And I successfully authenticate via Google
    Then I should be redirected to my user page
    And I should see "You are logged in."
