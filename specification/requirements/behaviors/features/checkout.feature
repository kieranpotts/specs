Feature: Check out a basket
  In order to buy the products I have chosen
  As a Shopper
  I want to check out my basket and pay in a single operation

  Scenario: Check out a basket of available products
    Given an authenticated Shopper caller
      And the Shopper's basket contains products "abc123" and "def456"
      And both products have status "available"
     When the Shopper checks out the basket with a valid payment method
     Then the payment is captured for the basket total
      And an order is created recording both products and the payment
      And the products "abc123" and "def456" both become "sold"
      And the basket is emptied

  Scenario: Check out a product the Shopper already holds a reservation on
    Given an authenticated Shopper caller who also holds a Partner reservation on "abc123"
      And the Shopper's basket contains product "abc123"
     When the Shopper checks out the basket with a valid payment method
     Then the payment is captured
      And the product "abc123" moves from "reserved" to "sold"
      And the reservation is consumed by the sale

  Scenario: Checkout is rejected when a product is already sold
    Given an authenticated Shopper caller
      And the Shopper's basket contains product "abc123"
      And the product "abc123" has status "sold"
     When the Shopper checks out the basket
     Then the response indicates the product is no longer purchasable
      And no payment is captured
      And no order is created

  Scenario: Checkout is rejected when a product is reserved by another holder
    Given an authenticated Shopper caller
      And the Shopper's basket contains product "abc123"
      And the product "abc123" is reserved by a different holder
     When the Shopper checks out the basket
     Then the response indicates the product is not available to buy
      And no payment is captured
      And the product "abc123" remains "reserved" by its existing holder

  Scenario: A declined payment leaves the basket unsold
    Given an authenticated Shopper caller
      And the Shopper's basket contains product "abc123" with status "available"
     When the Shopper checks out the basket and the payment provider declines the card
     Then the response indicates the payment was declined
      And the product "abc123" remains "available"
      And no order is recorded as paid

  Scenario: A payment-provider outage leaves the basket unsold
    Given an authenticated Shopper caller
      And the Shopper's basket contains product "abc123" with status "available"
     When the Shopper checks out the basket and the payment provider is unavailable
     Then the response indicates checkout could not be completed and may be retried
      And the product "abc123" remains "available"
      And no product is left in a partially-purchased state

  Scenario: An Authenticated User without Shopper standing cannot check out
    Given an authenticated caller who is not a Shopper
     When the caller attempts to check out a basket
     Then the response status indicates the request is forbidden

  Scenario: Unauthenticated request
    Given a caller is not authenticated
     When the caller attempts to check out a basket
     Then the response status indicates the request is unauthorized
      And no payment is captured
