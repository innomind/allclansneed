Feature: News Descriptions
As a User I want to see the current news
As an Admin I want to create, edit and delete news
An admin should only be allowed to administrate News if he has the propper right

  Scenario: Show news list
  	Given 1 Site
  	And I am logged in
  	And the news with title "test"
  	When I go to news
  	Then I should see "test"
  	
  @rights
  Scenario: News protection for guests
    Given 1 Site
    And I am logged in
  	And the news with title "test"
  	When I log out
  	And I go to new news
  	Then I should not see "News erstellen"
  	And I should see "Du hast nicht das nötige Recht"