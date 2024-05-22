Feature: Search for other users

  Users should be able to search for specific users to follow and connect with.

  Scenario: Search for a user by name
    Given I am a registered user
    When I navigate to the "Search Users" page
    And I tap on the search bar
    And I enter a name in the search bar
    Then I should see a list of users whose usernames start with the name I wrote
