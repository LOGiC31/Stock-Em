Feature: User Profile Showcase and Update
  As a user
  I want to view and update my profile information
  So that I can keep my details accurate and up to date

  Scenario: Viewing a user profile
    Given I am on the home page
    When I click on "Login with Google"
    And I successfully authenticate via Google
    Then I should be redirected to my user page
    When I visit the profile page of another user
    Then I should see the user's profile information

  @javascript
  Scenario: Successfully updating my user profile
    Given I am on the home page
    When I click on "Login with Google"
    And I successfully authenticate via Google
    Then I should be redirected to my user page
    When I click on "User Profile"
    When I visit my profile page
    And I press button "Edit Profile"
    And I am clicking on "commit"
    
