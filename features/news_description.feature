Feature: News Descriptions
As a User I want to see the current news
As an Admin I want to create, edit and delete news
An admin should only be allowed to administrate News if he has the propper right

Scenario: Show news list

	Given the news for a Site
	When I go to news
	Then I should see the news for the site
	