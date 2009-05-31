Feature: Manage leave_requests
  In order to manage employee leave requests more efficiently and online
  TALHO executives
  want employees to request their leave through the employee portal
  
  Scenario: Go to leave request form
    Given Keith is on the employee portal
    When Keith clicks "New Leave Request"
    Then Keith should go to the Leave Request form

  Scenario: Request leave
    Given Keith is on the Leave Request form
    When Keith requests an afternoon of Leave for a Doctor's appointment
    Then a leave request should be created with a single leave period
    And a new Leave Request should appear in the admin console 
