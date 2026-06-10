# Latency

Latency is the time between a user action and the system's response.

_State maximum acceptable latency for each class of user-facing operation, ideally at a named percentile. Examples: The time to first byte for all web pages MUST be under 1.5 seconds at the 95th percentile under normal load. API responses for read operations MUST be returned within 200ms at the 99th percentile._

For the Petstore API:

- The **list pets** and **search pets** endpoints MUST return a response within 300ms at the 95th percentile under normal load.

- The **get pet by ID** endpoint MUST return a response within 100ms at the 99th percentile under normal load.

- The **reserve** and **release** endpoints MUST return a response within 400ms at the 95th percentile under normal load. The slightly higher budget reflects the write path's need to acquire a hold and persist state.

- Under peak load, latency for all endpoints MUST NOT exceed 1 second at the 99th percentile.
