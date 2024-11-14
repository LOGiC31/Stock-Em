Feature: be able to check in and check out items

  As a capstone professor
  So that I can track the history of items
  I want to be able to view the checkin and checkout history of an item

Background: items in database

  Given the following items exist:
  | serial_number | item_name  | category    | quality_score | currently_available | details  | created_at | updated_at |
  | SN1           | Item One   | Furnitures  | 50            | true                | ""       | 2024-10-01 | 2024-10-02 |
  | SN2           | Item Two   | Electronics | 75            | false               | "abc"    | 2024-10-02 | 2024-10-02 |
  
  Given the following users exist:
  | user_id | name      | uin      | email        | contact_no   | role           | auth_level |
  | nilid   | Mark Polo | 1314234  | mark@ex.com  | 5556667777   | student_admin  | 2          |
  
Scenario: view an available item and see Checkout
  Given I am logged in
  And   I am on the details page for the item "SN1"
  Then  I should see "Checkout"
  And   I should not see "Checkin"

Scenario: view an unavailable item and see Checkin
  Given I am logged in
  And   I am on the details page for the item "SN2"
  Then  I should not see "Checkout"
  And   I should see "Checkin"

Scenario: Checkout follows the correct UI flow
  Given I am logged in
  And   I am on the details page for the item "SN1"
  And   I click on "Checkout"
  And   I fill in "professor" with "abcd"
  And   I fill in "teams" with "can"
  And   I select "EABA" from "location"
  And   I fill in "comments" with "car"
  And   I press "Publish"
  And   I should see "Checkin"
  And   I should see "EABA"

Scenario: Checkin follows the correct UI flow
  Given I am logged in
  And   I am on the details page for the item "SN2"
  And   I click on "Checkin"
  And   I fill in "professor" with "abcd"
  And   I select "EABB" from "location"
  And   I fill in "comments" with "car"
  And   I press "Publish"
  And   I should see "Checkout"
  And   I should see "EABB"

Scenario: Checkin fails when custom location is not specified
  Given I am logged in
  And   I am on the details page for the item "SN2"
  And   I click on "Checkin"
  And   I fill in "professor" with "abcd"
  And   I select "Others" from "location"
  And   I press "Publish"
  And   I should see "Custom location can't be blank when 'Other' is selected."
  And   I should not see "Others"

Scenario: Checkout fails when custom location is not specified
  Given I am logged in
  And   I am on the details page for the item "SN1"
  And   I click on "Checkout"
  And   I fill in "professor" with "abcd"
  And   I fill in "teams" with "can"
  And   I select "Others" from "location"
  And   I fill in "comments" with "car"
  And   I press "Publish"
  And   I should see "Custom location can't be blank when 'Other' is selected."
  And   I should not see "Others"