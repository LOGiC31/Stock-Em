Feature: Item Database
  As a professor or TA
  I want to verify that items are present in the database

  Scenario: Check if items exist in the database
    Given the following items exist:
      | item_name     | serial_number | category    | quality_score | currently_available |
      | Oscilloscope  | 12345         | Electronics | 9             | true                |
      | Resistor      | 54321         | Electronics | 10            | true                |
    When I check the item database
    Then I should see that "Oscilloscope" and "Resistor" are present