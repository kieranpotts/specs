# Capacity

Capacity is the maximum load the system must support — concurrent users, data
volume, or other resource limits — without degradation below the specified
[latency](./latency.md) and [throughput](./throughput.md) thresholds.

_State the capacity targets the system MUST meet. Examples: The system MUST
support at least 10,000 concurrent authenticated users. The system MUST remain
operational with a dataset of at least 100 million records without degradation
of query performance._

For the Acme Catalog API:

- The API MUST support at least 5,000 concurrent authenticated callers without
  degradation below the [latency](./latency.md) or [throughput](./throughput.md)
  thresholds.

- The catalog MUST remain fully queryable with at least 50,000 product records
  without degradation of list, search, or retrieval response times.
