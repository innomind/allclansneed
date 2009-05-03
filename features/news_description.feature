Feature: News Descriptions
As a User I want to see the current news
As an Admin I want to create, edit and delete news
An admin should only be allowed to administrate News if he has the propper right

  Background:
    Given 1 Site
    
  Scenario: Show news list
  	Given I am logged in
  	And I create a news with title "test"
  	When I go to news
  	Then I should see "test"
  	
  @rights
  Scenario: News protection for guests
    Given I am logged in
    And I create a news with title "test"
    When I log out
    And I go to news
  	Then I should not have right for new_onenews_path
  	And I should not have right for edit_onenews_path(1)