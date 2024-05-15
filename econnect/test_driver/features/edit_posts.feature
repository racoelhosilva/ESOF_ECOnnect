Feature: users control their shared content

  Users should be able to edit/delete their own posts

  Scenario: I edit a previous post
    Given I am a user
    And I have previously shared content
    When I visit my profile
    And I tap one of my posts
    Then I will be redirected to a page to edit information about the post

  Scenario: I delete a previous post
    Given I am a user
    And I have previously shared content
    When I visit my profile
    And I tap one of my posts
    And I tap the "Delete" button
    Then I the post is deleted from the app
    And it won't be accessible/visible