Feature: SSO Login
  As a user
  I want to log in using SSO
  So that I can securely access the application

  Scenario: Successful login via Google OAuth
    Given I am on the home page
    When I click on "Login with Google"
    And I successfully authenticate via Google
    Then I should be redirected to my user page
    And I should see "Howdy,"

  Scenario: Logout after login
    Given I am on the home page
    When I click on "Login with Google"
    And I successfully authenticate via Google
    Then I should be redirected to my user page
    And I should see "Howdy,"
    When I click on "Logout"
    Then I should be redirected to the welcome page
    And I should see "Login with Google"

  Scenario: Redirect to user page with welcome notice
    Given I am on the home page
    When I click on "Login with Google"
    And I successfully authenticate via Google
    Then I click on "View Items"
    When I visit the home page
    And I should see "Howdy,"

  Scenario: Failed access when i access items page without login
    Given I am on the home page
    When I visit the items page
    And I should see "You must be logged in to access this section."
