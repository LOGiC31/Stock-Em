Feature: be able to import and export sheets of items

  As a capstone professor
  So that I can quickly add / extract large amounts of items at once
  I want to be able to quickly import or export items to/from the website

  Background: items in database

    Given the following items exist:
      | serial_number | item_name  | category    | quality_score | currently_available | details  | created_at | updated_at |
      | SN1           | Item One   | Furniture  | 50            | true                | ""       | 2024-10-01 | 2024-10-02 |
      | SN2           | Item Two   | Electronics | 75            | false               | "abc"    | 2024-10-02 | 2024-10-02 |

    Given the following users exist:
      | user_id | name      | uin      | email        | contact_no   | role           | auth_level |
      | nilid   | Mark Polo | 1314234  | mark@ex.com  | 5556667777   | student_admin  | 2          |

  Scenario: Exporting the items
    Given I am logged in
    And I am an admin user
    And   I am on the items home page
    When  I click on "Export Items"
    Then  I should see "Electronics"

  Scenario: Importing the items
    Given I am logged in
    And I am an admin user
    And   I am on the items home page
    When  I throw in a file