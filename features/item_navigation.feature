Feature: be able to navigate and view all items

  As a capstone professor
  So that I can see which items are available for checkout
  I want to be able to quickly identify information about all the items

Background: items in database

  Given the following items exist:
  | serial_number | item_name  | category    | quality_score | currently_available | details  | created_at | updated_at |
  | SN1           | Item One   | Furniture   | 50            | true                | ""       | 2024-10-01 | 2024-10-02 |
  | SN2           | Item Two   | Electronics | 75            | true                | "abc"    | 2024-10-02 | 2024-10-02 |
  | SN3           | Item Three | Furniture   | 0             | false               | "comfy!" | 2024-10-02 | 2024-10-03 |
  | SN4           | Item Four  | Instrument  | 50            | true                | "hello"  | 2024-10-01 | 2024-10-01 |

Scenario: view all items
  Given I am logged in
  And   I am on the items home page
  Then  I should see "Items"

Scenario: view a specific item
  Given I am logged in
  And   I am on the details page for the item "SN2"
  Then  I should see "Item Two"
  And   I should see "SN2"
  And   I should see "Electronics"
  And   I should see "75"
  But   I should not see "Item One"
  And   I should not see "SN1"
  And   I should not see "Furniture"
  And   I should not see "comfy!"

Scenario: going back to the main page
  Given I am logged in
  And   I am on the details page for the item "SN1"
  And   I follow "Back to Items"
  Then  I should be on the home page