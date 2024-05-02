Feature: Follow and Unfollow other users

  Users should be able to select another user and follow them by visiting their profile page
  Users should also be able to unfollow another user from their profile page

  Scenario: Follow another user from their profile
    Given I am a registered user
    And I am visiting another user's profile
    When I tap the star icon to follow the user
    Then I will start following that user
    And their activity/shared content will be prioritized in my feed

  Scenario: Follow button state after following a user
    Given I am a registered user
    And I am already following another user
    When I visit their profile page again
    Then the star icon will be solid to indicate that I'm following the user

  Scenario: Unfollow a user
    Given I am a registered user
    And I am following another user
    When I visit the profile page of the user I'm following
    And I tap the unfollow button
    Then I will stop following that user
    And their activity/shared content will no longer be prioritized in my feed

  Scenario: Unfollow button state after unfollowing a user
    Given I am a registered user
    And I am not following another user
    When I visit their profile page
    Then the follow button will be hollow which is the base state
