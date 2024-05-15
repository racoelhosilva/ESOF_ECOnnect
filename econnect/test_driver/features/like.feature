Feature: Post interaction/rating

  Users should be able to like posts from other users

  Scenario:
    Given I am a user
    And I see a post (mine or from other user) which I like
    When I tap on "Like" button near the post
    Then the like count will be incremented
    And the feedback will be shared with the author of the post
    And the rank of the challenge(s) associated with the post will be updated