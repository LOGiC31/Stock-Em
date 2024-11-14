Feature: be able to store comments about items

  As a capstone professor
  So that I can add additional important information about an item
  I want to be able to add notes or comments to describe specific items

Background: items in database

  Given the following items exist:
  | serial_number | item_name  | category    | quality_score | currently_available | details  | created_at | updated_at |
  | SN1           | Item One   | Furnitures  | 50            | true                | ""       | 2024-10-01 | 2024-10-02 |
  | SN2           | Item Two   | Electronics | 75            | true                | "abc"    | 2024-10-02 | 2024-10-02 |
  
  Given the following users exist:
  | user_id | name      | uin      | email        | contact_no   | role           | auth_level |
  | nilid   | Mark Polo | 1314234  | mark@ex.com  | 5556667777   | student_admin  | 2          |
  
  Given the following notes exist:
  | note_id   | item_id | msg                     | user_id | created_at |
  | note1     | 1       | my first noteone!       | 1       | 2024-10-02 |
  | note2     | 1       | my first notetwo!       | 1       | 2024-10-01 |

Scenario: view a specific item and see notes
  Given I am logged in
  And   I am on the details page for the item "SN1"
  Then  I should see "my first noteone!"
  And   I should see "my first notetwo!"

Scenario: notes are displayed from most recent to least recent
  Given I am logged in
  And   I am on the details page for the item "SN1"
  Then  I should see "my first notetwo!" before "my first noteone!"

Scenario: no text box shown until create note is called
  Given I am logged in
  And I am an admin user
  And   I am on the details page for the item "SN2"
  Then  I should see "Create Note"
  And   I should not see "Publish"

Scenario: adding a note follows the correct UI flow as an admin
  Given I am logged in
  And I am an admin user
  And   I am on the details page for the item "SN2"
  And   I follow "Create Note"
  And   I fill in "note_msg" with "abcdefgh"
  And   I press "Publish"
  Then  I should see "Create Note"
  And   I should not see "Publish"
  And   I should see "abcdefgh"

Scenario: adding a note follows the correct UI flow as an assistant
  Given I am logged in
  And I am an assistant user
  And   I am on the details page for the item "SN2"
  And   I follow "Create Note"
  And   I fill in "note_msg" with "abcdefgh"
  And   I press "Publish"
  Then  I should see "Create Note"
  And   I should not see "Publish"
  And   I should see "abcdefgh"

Scenario: adding a note follows the correct UI flow as a student
  Given I am logged in
  And   I am on the details page for the item "SN2"
  Then I should not see "Create Note"