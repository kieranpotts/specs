Feature: List pets
  In order to browse available animals
  As an Authenticated User
  I want to retrieve a paginated list of pets from the catalog

  Scenario: List all available pets
    Given an Authenticated User is authenticated
     When the user requests the list of pets
     Then the response contains a list of pet records
      And each record includes the pet's id, name, species, breed, status, and price
      And the list is ordered by id ascending by default

  Scenario: Paginate the pet list
    Given an Authenticated User is authenticated
      And the catalog contains more pets than the default page size
     When the user requests the list of pets with a page size of 10
     Then the response contains at most 10 pet records
      And the response includes a cursor or page token for retrieving the next page

  Scenario: Filter by status
    Given an Authenticated User is authenticated
     When the user requests pets filtered by status "available"
     Then every pet in the response has status "available"
      And pets with status "reserved" or "sold" are not included

  Scenario: Filter by species
    Given an Authenticated User is authenticated
     When the user requests pets filtered by species "dog"
     Then every pet in the response belongs to the species "dog"

  Scenario: Filter by price range
    Given an Authenticated User is authenticated
     When the user requests pets with a minimum price of 100 and a maximum price of 500
     Then every pet in the response has a price between 100 and 500 inclusive

  Scenario: Empty result set
    Given an Authenticated User is authenticated
      And no pets match the applied filters
     When the user requests the list of pets with those filters
     Then the response contains an empty list
      And the response does not indicate an error

  Scenario: Unauthenticated request
    Given a caller is not authenticated
     When the caller requests the list of pets
     Then the response status indicates the request is unauthorized
      And no catalog data is returned
