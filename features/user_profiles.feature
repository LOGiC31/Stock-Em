Feature: User Profile Management
  As a user
  I want to manage my user profile
  So that I can view and update my information

  Scenario: Viewing my user profile
    Given I am on the home page
    When I click on "Login with Google"
    And I successfully authenticate via Google
    When I visit my user profile page
    Then I should see my profile information
