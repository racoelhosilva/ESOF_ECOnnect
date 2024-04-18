Feature: Publishing new posts

  Users should be able to create new posts

  Scenario:
    Given I am a user
    And I've already selected some content to share
    When I fill the information fields
    And I tap the "Publish" button
    Then a new post is created with the content I've selected
    And it will be visible to the users