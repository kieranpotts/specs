Feature: Capture payment for an order
  In order to complete a purchase without being charged twice on a retry
  As a Shopper
  I want payment capture to be safe to retry under an idempotency key

  Scenario: Capture a payment for a checked-out basket
    Given an authenticated Shopper caller checking out a basket totalling 120.00
     When the Shopper submits payment with idempotency key "pay-1"
     Then the payment is authorized and captured for 120.00
      And the payment status becomes "captured"
      And the order is recorded as "paid"

  Scenario: Retrying capture with the same idempotency key does not charge twice
    Given the Shopper has captured a payment for a basket using idempotency key "pay-1"
     When the Shopper submits the same checkout again using idempotency key "pay-1"
     Then the response returns the result of the original capture
      And no second charge is made
      And the order still records exactly one payment

  Scenario: A declined card yields no captured payment
    Given an authenticated Shopper caller checking out a basket
     When the Shopper submits payment and the provider declines the card
     Then the payment status becomes "declined"
      And no amount is captured
      And the order is recorded as "failed"

  Scenario: Card data is never stored by the system
    Given a Shopper submits card details at checkout
     When the payment is processed
     Then only a provider-issued token and the payment result are retained
      And no raw card number is persisted by the system
