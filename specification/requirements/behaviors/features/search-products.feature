Feature: [F2] Search products
  In order to find a specific product quickly
  As an Authenticated User
  I want to search the catalog by keyword and tag

  Scenario: [F2.1] Search by keyword
    Given an authenticated caller
     When the caller searches for products with the keyword "recliner"
     Then the response contains only products whose name, variant, or description contains "recliner"
      And the match is case-insensitive

  Scenario: [F2.2] Search by tag
    Given an authenticated caller
     When the caller searches for products tagged "eco-friendly"
     Then every product in the response has the tag "eco-friendly"

  Scenario: [F2.3] Combine keyword and tag filters
    Given an authenticated caller
     When the caller searches for products with the keyword "oak" and the tag "handmade"
     Then every product in the response matches both the keyword and the tag criteria

  Scenario: [F2.4] No results found
    Given an authenticated caller
     When the caller searches for products with the keyword "unicorn"
     Then the response contains an empty list
      And the response does not indicate an error

  Scenario: [F2.5] Unauthenticated request
    Given a caller is not authenticated
     When the caller searches the catalog
     Then the response status indicates the request is unauthorized
      And no catalog data is returned
