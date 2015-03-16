Feature: Write Articles
  As a blog administrator
  In order to avoid repeating articles on same topic 
  I want to be able to merge relevant articles into one article

  Background:
    Given the admin user and non-admin user is set up
	And I have an article with id "1", title "first" and content "test1"
	And I have an article with id "2", title "second" and conetent "test2"

  Scenario: A non-admin cannot merge two articles
    Given I am logged into the non-admin panel
    When I follow "first"
	Then I should not see "Merge Articles"
	
  Scenerio: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel
	When I follow "first"
	Then I should see "Merge Articles"
	When I fill in "merge_id" with "2"
	And I press "Merge"
	Then I should see "test1"
	Then I should see "test2"
	
