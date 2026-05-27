# Throughput

Throughput is the number of requests or transactions the system can process per unit of time.

_State the minimum throughput the system MUST sustain under normal and peak load conditions. For example:_

- The system MUST sustain at least 500 API requests per second under normal load without exceeding the [latency](./latency.md) thresholds.

- The system MUST sustain at least 1,500 API requests per second under peak load, with a graceful degradation in latency rather than hard failure.

For the Petstore API:

- The API MUST sustain at least 200 requests per second across all endpoints under normal load without breaching the [latency](./latency.md) thresholds.

- The API MUST sustain at least 600 requests per second under peak load, with graceful degradation in latency rather than hard failure or error responses.
