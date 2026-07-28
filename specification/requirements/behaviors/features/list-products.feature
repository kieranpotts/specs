Feature: [F1] List products
  In order to browse available products
  As an Authenticated User
  I want to retrieve a paginated list of products from the catalog

  Scenario: [F1.1] List all available products
    Given an authenticated caller
     When the caller requests the list of products
     Then the response contains a list of product records
      And each record includes the product's id, name, type, variant, status, and price
      And the list is ordered by id ascending by default

  Scenario: [F1.2] Paginate the product list
    Given an authenticated caller
      And the catalog contains more products than the default page size
     When the caller requests the list of products with a page size of 10
     Then the response contains at most 10 product records
      And the response includes a cursor or page token for retrieving the next page

  Scenario: [F1.3] Filter by status
    Given an authenticated caller
     When the caller requests products filtered by status "available"
     Then every product in the response has status "available"
      And products with status "reserved" or "sold" are not included

  Scenario: [F1.4] Filter by type
    Given an authenticated caller
     When the caller requests products filtered by type "furniture"
     Then every product in the response belongs to the type "furniture"

  Scenario: [F1.5] Filter by price range
    Given an authenticated caller
     When the caller requests products with a minimum price of 100 and a maximum price of 500
     Then every product in the response has a price between 100 and 500 inclusive

  Scenario: [F1.6] Empty result set
    Given an authenticated caller
      And no products match the applied filters
     When the caller requests the list of products with those filters
     Then the response contains an empty list
      And the response does not indicate an error

  Scenario: [F1.7] Unauthenticated request
    Given a caller is not authenticated
     When the caller requests the list of products
     Then the response status indicates the request is unauthorized
      And no catalog data is returned
