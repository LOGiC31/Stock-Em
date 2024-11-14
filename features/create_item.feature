Feature: Create a new item
  As a user
  I want to create a new item
  So that I can add it to the inventory

  Scenario: Successfully creating a new item with Assistant Login
    Given I am on the home page
    When I click on "Login with Google"
    And I am an assistant user
    Then I should be redirected to my user page
    When I click on "View Items"
    Then I should see "Create New Item"
    And I click on "Create New Item"
    When I fill in the item field "Item Name" with "Laptop"
    And I select "Electronics" from "category"
    And I fill in the item field "Quality Score" with "90"
    And I select "Yes" from "item_currently_available"
    And I fill in the item field "Serial Number" with "1234567890"
    And I press "Create Item"
    Then I should be on the "Items List" page
    And I should see "Laptop"

  Scenario: Attempt to create an item with missing required fields
    Given I am on the home page
    When I click on "Login with Google"
    And I am an assistant user
    Then I should be redirected to my user page
    When I click on "View Items"
    Then I should see "Create New Item"
    And I click on "Create New Item"
    Then I should be on the "New Item" page
    When I fill in the item field "Item Name" with ""
    And I select "Furniture" from "category"
    And I fill in the item field "Quality Score" with "85"
    And I select "Yes" from "item_currently_available"
    And I fill in the item field "Serial Number" with "5432109876"
    And I press the button "Create Item"

  Scenario: Validation error for invalid Quality Score
    Given I am on the home page
    When I click on "Login with Google"
    And I am an assistant user
    Then I should be redirected to my user page
    When I click on "View Items"
    Then I should see "Create New Item"
    And I click on "Create New Item"
    When I fill in the item field "Item Name" with "Table"
    And I select "Furniture" from "category"
    And I fill in the item field "Quality Score" with "150"
    And I select "No" from "item_currently_available"
    And I fill in the item field "Serial Number" with "1112223334"
    And I press "Create Item"
    And I should not see "Table"

  Scenario: Validation error for duplicate item
    Given I am on the home page
    When I click on "Login with Google"
    And I am an assistant user
    Then I should be redirected to my user page
    When I click on "View Items"
    Then I should see "Create New Item"
    And I click on "Create New Item"
    When I fill in the item field "Item Name" with "Table"
    And I select "Furniture" from "category"
    And I fill in the item field "Quality Score" with "30"
    And I select "No" from "item_currently_available"
    And I fill in the item field "Serial Number" with "1112223334"
    And I press "Create Item"
    And I click on "Create New Item"
    When I fill in the item field "Item Name" with "Chair"
    And I select "Furniture" from "category"
    And I fill in the item field "Quality Score" with "30"
    And I select "No" from "item_currently_available"
    And I fill in the item field "Serial Number" with "1112223334"
    And I press "Create Item"
    Then I should see "Item already exists with this serial number."
    And I should not see "Table"

  Scenario: Attempt to create an item with insufficient authorization
    Given I am on the home page
    When I click on "Login with Google"
    And I am a student user
    Then I should be redirected to my user page
    When I click on "View Items"
    Then I should not see "Create New Item"
