Feature: View shared content/recent activity

  Users should be able to see their previously shared content (if there is any) by visiting their profile page

  Scenario: User with existing posts
    Given I am a registered user
    And I have shared one or more posts
    When I visit my profile page
    Then I will see a button to create a new post
    And I will see my previous posts

  Scenario: User with no posts
    Given I am a registered user
    And I have not shared any posts
    When I visit my profile page
    Then I will only see a button to create a new post
