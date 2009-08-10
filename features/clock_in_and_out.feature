Feature: Clocking in and out
  In order streamline administrative operations and increase accountability
  As an employee
  I want to track time by clocking in and out
  
  Scenario: An employee clocking in
    Given "keith@example.com" is a user
    When "keith@example.com" clocks in
    Then I can see that "keith@example.com" is clocked in
  
  Scenario: An employee tries to clock in twice
		Given "keith@example.com" is a user
		When "keith@example.com" clocks in
		When "keith@example.com" clocks in
    Then I can see an error message
    
  Scenario: An employee clocking out
		Given "keith@example.com" is a user
    And "keith@example.com" is currently clocked in
    When "keith@example.com" clocks out
		Then I can see that "keith@example.com" is clocked out
