Feature: Manage leave_requests
  In order to manage employee leave requests more efficiently and online
  TALHO executives
  want employees to request their leave through the employee portal
  
  Scenario: Go to leave request form
    Given Keith is on the employee portal
    When Keith clicks "New Leave Request"
    Then Keith should go to the Leave Request form
    And Keith should see the "Employee" select box
    And Keith should see the "Reason" text box
    And Keith should see the "Add new" link
    And Keith should see the "Leave type" select box
    And Keith should see the "Save" button

  Scenario: Request leave
    Given Keith is on the Leave Request form
    When Keith requests an afternoon of Leave for a Doctor's appointment
    Then Keith should have a leave request created with a single leave period
    And Keith should have a leave request in the admin console

