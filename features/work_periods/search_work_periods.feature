Feature: Searching work periods
	In order to correct and add new work periods
	As an admin
	I want to search for existing work periods and add new ones

	Background:
    Given the following users exist:
    			| user  | keith@example.com |
    			| user  | ethan@example.com |
    			| admin | jason@example.com |

    And "keith@example.com" has the following work periods:
    		| 8/1/2009 8:00-8/1/2009 12:00  |
    		| 8/1/2009 13:00-8/1/2009 17:00 |
    		| 8/2/2009 8:00-8/2/2009 16:00  |
    And "ethan@example.com" has the following work periods:
        | 8/2/2009 8:00-8/2/2009 12:00  |
        | 8/3/2009 8:00-8/3/2009 16:00  |
 
	Scenario: searching for work periods
		Given I am logged in as "jason@example.com"
		And I am on the work period search page
		Then I should see the "Employee" field
		And I should see the "Start date" field
		And I should see the "End date" field

		When I fill in the form with the following info:
			| Start date | 8/1/2009 |
			| End date  | 8/1/2009 |
		And I press "Search"
		Then I should see 2 work periods
		 

