Feature: Clocking in and out
  In order streamline administrative operations and increase accountability
  As an employee
  I want to track time by clocking in and out
  
  Scenario: An employee clocking in
    Given Keith is an employee
    When Keith clocks in
    Then I can see that Keith is clocked in
    