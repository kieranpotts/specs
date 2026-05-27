Feature: Changelog
  In order to get the most from the application
  As a user
  I want to know what new features have been added recently

  Scenario: View the changelog
    Given an Authenticated User is logged in
     When the user views the changelog
     Then the user sees a list of product announcements and new features
      And the list is ordered in reverse chronological order, the most recent first
      And each entry in the list has a version number and a release date

  Scenario: View the detailed entry of a changelog entry
    Given an Authenticated User is logged in
      And the user is viewing the changelog
     When the user clicks on an entry in the changelog
     Then the user sees a detailed description of all the changes introduced in the selected release version

  # We want to keep the changelog hidden from the general public
  # while our startup is operating in stealth mode!
  Scenario: Unauthenticated user
    Given an Anonymous User is not logged in
     When the user views the changelog
     Then the user cannot see the changelog
