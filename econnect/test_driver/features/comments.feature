Feature: Comment on a post

 Users should be able to comment on posts

 Scenario: Successful comment on a post
   Given I am a user
   And I am logged in into my account
   And I am on a post that I want to comment on
   When I write a comment "This is a great post!" in the comment input field
   And I click the "Send" button
   Then my comment "This is a great post!" should be visible under the post
   And the comment input field should be cleared

 Scenario: Failed comment on a post due to empty content
   Given I am a user
   And I am logged in into my account
   And I am on a post that I want to comment on
   When I leave the comment input field empty
   And I click the "Send" button
   Then I should see an error message "Comment cannot be empty"
   And my comment should not be visible under the post