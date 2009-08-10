Feature: Manage leave_requests
  In order to manage employee leave requests more efficiently and online
  TALHO executives
  want employees to request their leave through the employee portal

  Background:
    Given "keith@example.com" is a user
    And "jason@example.com" is an admin
    And the following leave types exist:
    | Vacation | 610 |
    | Sick     | 611 |
    | Holiday  | 612 |

  Scenario: Employee requesting leave
    Given I am logged in as "keith@example.com"
    And I am on the new leave_requests page
    When I request leave for "Doctor's appointment" using "Vacation" time
    Then I should be redirected to the employee portal page
    And I should see 1 "Pending Leave Requests"

	Scenario: Admin approving leave
		Given "keith@example.com" has a pending leave request with the following info:
			| Reason | Doctor's appointment |
			| Leave periods | 8/1/2009 12:00-8/1/2009 13:00 |
			| Leave Type | Vacation |
		And I am logged in as "jason@example.com"
		When I go to the admin page
		Then I should see 1 "Pending Leave Requests" from "keith@example.com"
