Feature: Search pets
  In order to find a specific animal quickly
  As an Authenticated User
  I want to search the catalog by keyword and tag

  Scenario: Search by keyword
    Given an authenticated caller
     When the caller searches for pets with the keyword "retriever"
     Then the response contains only pets whose name, breed, or description contains "retriever"
      And the match is case-insensitive

  Scenario: Search by tag
    Given an authenticated caller
     When the caller searches for pets tagged "hypoallergenic"
     Then every pet in the response has the tag "hypoallergenic"

  Scenario: Combine keyword and tag filters
    Given an authenticated caller
     When the caller searches for pets with the keyword "golden" and the tag "house-trained"
     Then every pet in the response matches both the keyword and the tag criteria

  Scenario: No results found
    Given an authenticated caller
     When the caller searches for pets with the keyword "unicorn"
     Then the response contains an empty list
      And the response does not indicate an error

  Scenario: Unauthenticated request
    Given a caller is not authenticated
     When the caller searches the catalog
     Then the response status indicates the request is unauthorized
      And no catalog data is returned
