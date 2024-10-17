Feature: Show Item
  As a user
  I want to log in via Google OAuth and view the details of a specific item
  So that I can see all relevant information about it

  Scenario: Successful login via Google OAuth and viewing an item
    Given I am on the home page
    When I click on "Login with Google"
    And I successfully authenticate via Google
    Then I should be redirected to my user page
    And I should see "Howdy,"
    Given there is an item in the database
    When I visit the item page
    Then I should see the item's details