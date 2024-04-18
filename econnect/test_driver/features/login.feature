Feature: Logging in

  Users should be able to log in into their accounts using their information

  Scenario: I want to log in
    Given I am a registered user
    When I enter my username and password
    And I tap the "Login" button
    Then I will be logged into my account
    And I will be redirected to the main home page

  Scenario: I want to register
    Given I am a new user
    When I tap the "Register" button
    And I enter my username, email and password
    And I tap the "Submit" button
    Then I will have my account created
    And I will be logged into my account
    And I will be redirected to the main home page