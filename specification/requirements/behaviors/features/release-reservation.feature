Feature: Release a reservation
  In order to return a pet to the catalog when a sale falls through
  As a Partner
  I want to release a reservation that I hold

  Scenario: Release a reservation I hold
    Given an authenticated Partner caller
      And the pet with id "abc123" is reserved by the requesting Partner
     When the Partner releases the reservation on the pet with id "abc123"
     Then the response confirms the release
      And the pet's status becomes "available"
      And the pet no longer records a reservation holder

  Scenario: Cannot release another Partner's reservation
    Given an authenticated Partner caller
      And the pet with id "abc123" is reserved by a different Partner
     When the Partner releases the reservation on the pet with id "abc123"
     Then the response status indicates the request is forbidden
      And the pet's status remains "reserved"
      And the existing reservation's holder is unchanged

  Scenario: Releasing an already-available pet I previously held is a no-op
    Given an authenticated Partner caller
      And the pet with id "abc123" has status "available"
      And the requesting Partner held the most recent reservation on it
     When the Partner releases the reservation on the pet with id "abc123"
     Then the response confirms the pet is available
      And the response does not indicate an error

  Scenario: An Authenticated User without Partner standing cannot release
    Given an authenticated caller who is not a Partner
      And the pet with id "abc123" has status "reserved"
     When the caller attempts to release the reservation on the pet with id "abc123"
     Then the response status indicates the request is forbidden
      And the pet's status remains "reserved"

  Scenario: Unauthenticated request
    Given a caller is not authenticated
     When the caller attempts to release a reservation
     Then the response status indicates the request is unauthorized
      And no reservation is released
