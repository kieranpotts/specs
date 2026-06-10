Feature: Reserve a pet
  In order to hold an animal for a customer while a sale is arranged
  As a Partner
  I want to place a temporary reservation on an available pet

  Scenario: Reserve an available pet
    Given an authenticated Partner caller
      And a pet with id "abc123" has status "available"
     When the Partner reserves the pet with id "abc123"
     Then the response confirms the reservation
      And the pet's status becomes "reserved"
      And the reservation records the requesting Partner as the holder
      And the reservation records the time at which the hold expires

  Scenario: Cannot reserve a pet that is already reserved
    Given an authenticated Partner caller
      And a pet with id "abc123" has status "reserved"
     When the Partner reserves the pet with id "abc123"
     Then the response indicates the pet is not available to reserve
      And the pet's status remains "reserved"
      And the existing reservation's holder is unchanged

  Scenario: Cannot reserve a sold pet
    Given an authenticated Partner caller
      And a pet with id "abc123" has status "sold"
     When the Partner reserves the pet with id "abc123"
     Then the response indicates the pet is not available to reserve
      And the pet's status remains "sold"

  Scenario: Retrying a reservation with the same idempotency key is safe
    Given an authenticated Partner caller
      And the Partner has reserved the pet with id "abc123" using idempotency key "key-1"
     When the Partner reserves the pet with id "abc123" again using idempotency key "key-1"
     Then the response confirms the same reservation as the original request
      And no second hold is created

  Scenario: An Authenticated User without Partner standing cannot reserve
    Given an authenticated caller who is not a Partner
      And a pet with id "abc123" has status "available"
     When the caller attempts to reserve the pet with id "abc123"
     Then the response status indicates the request is forbidden
      And the pet's status remains "available"

  Scenario: Unauthenticated request
    Given a caller is not authenticated
     When the caller attempts to reserve a pet
     Then the response status indicates the request is unauthorized
      And no pet is reserved
