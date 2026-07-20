Feature: Get product by ID
  In order to see the full details of a product I am interested in
  As an Authenticated User
  I want to retrieve a single product record by its unique identifier

  Scenario: Retrieve an existing product
    Given an authenticated caller
      And a product with id "abc123" exists in the catalog
     When the caller requests the product with id "abc123"
     Then the response contains the full product record
      And the record includes id, name, type, variant, price, status, description, photoUrls, tags, and category

  Scenario: Product not found
    Given an authenticated caller
      And no product with id "xyz999" exists in the catalog
     When the caller requests the product with id "xyz999"
     Then the response status indicates the resource was not found
      And no product data is returned

  Scenario: Unauthenticated request
    Given a caller is not authenticated
     When the caller requests a product by ID
     Then the response status indicates the request is unauthorized
      And no catalog data is returned
