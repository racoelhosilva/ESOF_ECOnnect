Feature: Camera access

  Users should be able to access the camera from the app

  Scenario:
    Given I am a user
    And I have given the app permission to access the camera
    When I tap on "New Post" button
    And I tap the "Camera" button
    Then the camera app will be launched
    And I can take a photo to post directly into the app
