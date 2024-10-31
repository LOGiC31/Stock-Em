Feature: Search and filter items
  As a user
  I want to search the items and/or filter by availability

  Background:
    Given the following items exist:
    | serial_number  | item_name | category     | status      | quality_score | currently_available | details  | created_at  | updated_at  |
    | SN1            | Laptop1   | Electronics  | lost        | 50            | true                | ""       | 2024-10-01  | 2024-10-02  |
    | SN2            | Chair     | Furnitures    | damaged     | 75            | true                | "abc"    | 2024-10-02  | 2024-10-02  |
    | SN3            | Tablet    | Electronics  | lost        | 0             | false               | "comfy!" | 2024-10-02  | 2024-10-03  |
    | SN4            | Laptop2   | Electronics  | damaged     | 55            | false               | ""       | 2024-10-01  | 2024-10-02  |
    | SN5            | Desk      | Furnitures    | lost        | 60            | true                | "study"  | 2024-10-03  | 2024-10-04  |


  Scenario: Search items by name
    Given I am logged in
    And I am on the items home page
    When I search for "lap"
    Then I should see "Laptop1"
    Then I should see "Laptop2"
    And I should not see "Chair"
    And I should not see "Tablet"

  Scenario: Search items by category
    Given I am logged in
    And I am on the items home page
    When I search for "Electronics"
    Then I should see "Laptop1"
    Then I should see "Laptop2"
    And I should see "Tablet"
    And I should not see "Chair"

  Scenario: Filter items by availability
    Given I am logged in
    And I am on the items home page
    When I filter by availability
    Then I should see "Laptop1"
    And I should see "Chair"
    And I should not see "Tablet"
    And I should not see "Laptop2"

  Scenario: Search and Filter items by availability
    Given I am logged in
    And I am on the items home page
    When I search for "lapt" and filter by availability
    Then I should see "Laptop1"
    And I should not see "Chair"
    And I should not see "Tablet"
    And I should not see "Laptop2"

  Scenario: Filter dropdown items by status
    Given I am logged in
    And I am on the items home page
    When I click on the status dropdown
    When I select "Lost" from the status dropdown list
    When I click Filter
    Then I should see "Laptop1"
    And I should see "Tablet"
    And I should see "Desk"
    And I should not see "Chair"
    And I should not see "Laptop2"

  Scenario: Filter dropdown items by category
    Given I am logged in
    And I am on the items home page
    When I click on the category dropdown
    When I select "Electronics" from the category dropdown list
    When I click Filter
    Then I should see "Laptop1"
    And I should see "Tablet"
    And I should see "Laptop2"
    And I should not see "Chair"
    And I should not see "Desk"