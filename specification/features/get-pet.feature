Feature: Get pet by ID
  In order to see the full details of an animal I am interested in
  As an Authenticated User
  I want to retrieve a single pet record by its unique identifier

  Scenario: Retrieve an existing pet
    Given an Authenticated User is authenticated
      And a pet with id "abc123" exists in the catalog
     When the user requests the pet with id "abc123"
     Then the response contains the full pet record
      And the record includes id, name, species, breed, age, price, status, description, photoUrls, tags, and category

  Scenario: Pet not found
    Given an Authenticated User is authenticated
      And no pet with id "xyz999" exists in the catalog
     When the user requests the pet with id "xyz999"
     Then the response status indicates the resource was not found
      And no pet data is returned

  Scenario: Unauthenticated request
    Given a caller is not authenticated
     When the caller requests a pet by id
     Then the response status indicates the request is unauthorized
      And no catalog data is returned
