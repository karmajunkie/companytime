Feature: Editing profiles

Background:
	Given the following users exist:
		| user  | keith@example.com |
		| user  | ethan@example.com |
		| admin | jason@example.com |

Scenario: User editing another user's profile
	Given I am logged in as "keith@example.com"
	When I visit the edit user page for "ethan@example.com"
	Then I should see "You are not authorized"
	
Scenario: Admin editing a user's profile
	Given I am logged in as "jason@example.com"
	When I visit the edit user page for "ethan@example.com"
	Then I should see the edit user page for "ethan@example.com"

	When I fill in the form with the following info:
		| First name            | Ethan                 |
		| Last name             | Waldo                 |
		| Email                 | ethan@applesauce.com  |
		| Password              | applesauce            |
		| Password confirmation | applesauce            |
	And I press "Save"
	Then I should see the user profile page for "ethan@applesauce.com"

Scenario: User editing own profile
#	When I fill in the