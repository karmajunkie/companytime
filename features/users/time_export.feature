Feature: Exporting time in a spreadsheet
  In order to use the time stored in the database in other applications
  As I user
  I want to download my time for a given month as a spreadsheet

  Background:
    Given "keith@example.com" is a user
    And "keith@example.com" has the following work periods:
      | 8/1/2009 8:00-8/1/2009 12:00  |
      | 8/1/2009 13:00-8/1/2009 17:00 |
      | 8/2/2009 8:00-8/2/2009 16:00  |
      | 8/3/2009 8:00-8/3/2009 16:00  |
      | 8/4/2009 8:00-8/4/2009 12:00  |
      | 8/4/2009 13:00-8/4/2009 17:00  |

  Scenario: Downloading the time export
    Given I am logged in as "keith@example.com"
    When I go to the employee portal page
    Then I should see "Export Time"
    When I select "August 2009" as the export date
    And I press "Export"
    Then I should receive a file "time_export_200908.xls"
    And the downloaded file should have the content type "application/msexcel"
    And the file should contain the following information:
      | (Saturday) 1  | 8:00 | 17:00 |
      | (Sunday) 2    | 8:00 | 16:00 |
      | 3             | 8:00 | 16:00 |
      | 4             | 8:00 | 17:00 |


