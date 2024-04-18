Feature: Gallery/storage access

  Users should be able to upload content from the gallery to the app

  Scenario:
    Given I am a user
    And I have given the app permission to access the storage
    When I tap on "New Post" button
    And I tap the "Gallery" button
    Then the gallery app will be launched
    And I can choose a photo to post into the app