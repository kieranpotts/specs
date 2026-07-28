Feature: [F4] Reserve a product
  In order to hold a product for a customer while a sale is arranged
  As a Partner
  I want to place a temporary reservation on an available product

  @R1 @R3
  Scenario: [F4.1] Reserve an available product
    Given an authenticated Partner caller
      And a product with id "abc123" has status "available"
     When the Partner reserves the product with id "abc123"
     Then the response confirms the reservation
      And the product's status becomes "reserved"
      And the reservation records the requesting Partner as the holder
      And the reservation records the time at which the hold expires

  @R3
  Scenario: [F4.2] Cannot reserve a product that is already reserved
    Given an authenticated Partner caller
      And a product with id "abc123" has status "reserved"
     When the Partner reserves the product with id "abc123"
     Then the response indicates the product is not available to reserve
      And the product's status remains "reserved"
      And the existing reservation's holder is unchanged

  @R3
  Scenario: [F4.3] Cannot reserve a sold product
    Given an authenticated Partner caller
      And a product with id "abc123" has status "sold"
     When the Partner reserves the product with id "abc123"
     Then the response indicates the product is not available to reserve
      And the product's status remains "sold"

  @R3
  Scenario: [F4.4] Retrying a reservation with the same idempotency key is safe
    Given an authenticated Partner caller
      And the Partner has reserved the product with id "abc123" using idempotency key "key-1"
     When the Partner reserves the product with id "abc123" again using idempotency key "key-1"
     Then the response confirms the same reservation as the original request
      And no second hold is created

  @R3
  Scenario: [F4.5] An Authenticated User without Partner standing cannot reserve
    Given an authenticated caller who is not a Partner
      And a product with id "abc123" has status "available"
     When the caller attempts to reserve the product with id "abc123"
     Then the response status indicates the request is forbidden
      And the product's status remains "available"

  @R3
  Scenario: [F4.6] Unauthenticated request
    Given a caller is not authenticated
     When the caller attempts to reserve a product
     Then the response status indicates the request is unauthorized
      And no product is reserved
