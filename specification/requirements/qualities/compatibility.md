# Compatibility

## Web browser support

_Set concrete minimum versions and review them on a defined cadence. A common
policy is to support the latest two major versions of each browser._

The client application MUST be distributable as a bundle compatible with the
following mainstream web browsers, at the given versions or later (release dates
in parentheses):

- Chrome vXX (MM YYYY)
- Firefox vXX (MM YYYY)
- Safari vXX (MM YYYY)

## API protocol compatibility

The Petstore API is a digital service accessible to both human-operated client
applications and automated systems. It is not tied to any specific transport or
serialization technology; however, the following compatibility commitments apply
to the current production implementation:

- The API MUST be consumable by any HTTP client capable of making authenticated
  requests and parsing structured response payloads.

- The API MUST NOT require a proprietary SDK or runtime to consume; all
  interactions MUST be achievable using standard HTTP tooling.

- The API MUST maintain backwards compatibility within a major version: existing
  fields MUST NOT be removed or renamed, and existing endpoint paths MUST NOT
  change without a prior deprecation period of at least 90 days.
