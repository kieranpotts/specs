# Qualities

This section sets out the system's non-functional requirements — its quality
attributes and performance targets.

The scope here is the system's _dynamic_ quality attributes: those observable at
runtime, in how the system behaves for real users in production (latency,
availability, security, and so on). _Static_ quality attributes — the internal
qualities of the code and design — are not requirements the specification
states. They are a design concern, addressed in code review and refactoring, and
so are out-of-scope here.

Where [features](../behaviors/features/) describe _what_ the system does, this
section describes _how well_ it must do it at runtime, and the constraints (eg.
hardware resources) within which it must operate.

These requirements are architecturally significant. They have a big impact on
the design of the system, and on the components and tools that can be used to
build and deploy it.

_State each requirement as a measurable, testable threshold rather than a
general aspiration. Vague requirements cannot be verified._

## Organization

Qualities are grouped into subdirectories by quality characteristic, following
the product quality model of [ISO/IEC
25010](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010). The
model's eight applicable characteristics are: functional suitability,
performance efficiency, compatibility, interaction capability, reliability,
security, flexibility, and safety.

Only the characteristics this system actually has requirements under appear
here. There is no value in an empty directory for a characteristic the system
makes no commitments about — add one when the first requirement under it is
written.

ISO/IEC 25010 also defines a _maintainability_ characteristic (modularity,
reusability, testability). It is deliberately excluded: those are static
qualities, addressed through code design and refactoring, not requirements the
business specifies. Where a maintenance concern is genuinely observable at
runtime — the time taken to restore service after a fault, say — it belongs
under **reliability** as a recoverability requirement.

**Security** here covers non-functional concerns: encryption, audit logging,
and compliance-driven constraints (eg. AES-256 at rest, TLS 1.3 in transit,
GDPR Article 32). Authorization and permissions — who may do what — are a
functional concern and belong in
[`behaviors/access/`](../behaviors/access/) (the permission matrix) and as
user stories in [`behaviors/features/`](../behaviors/features/) (eg. "As an
admin, I can revoke a user's session so that..."), not here.

## Contents

_These are illustrative examples. Add, remove, or replace them with the quality
attributes that actually matter for your system._

### Compatibility

- **Q1** [**Browser and API
  compatibility**](./compatibility/browser-and-api-compatibility.md): The web
  browsers and devices supported by the client application, and the
  compatibility commitments the API makes to its consumers.

### Performance efficiency

- **Q2** [**Latency**](./performance-efficiency/latency.md): Maximum acceptable
  response times for user-facing operations.

- **Q3** [**Throughput**](./performance-efficiency/throughput.md): The volume of
  requests or transactions the system must sustain.

- **Q4** [**Capacity**](./performance-efficiency/capacity.md): The maximum load
  the system must support without degradation.

### Flexibility

- **Q5** [**Portability**](./flexibility/portability.md): The ease with which
  the system can be moved between host environments.

### Reliability

- **Q6** [**Idempotence**](./reliability/idempotence.md): The guarantee that
  operations can be retried safely without unintended side effects.

Identifiers are unaffected by this grouping. `Q1` remains `Q1` regardless of
which directory holds it, and an identifier is never reused. Grouping is a
navigational aid, not part of a requirement's identity.

## Deprecation

A quality whose withdrawal has been agreed, but which still holds in
production, is marked with a bold **Deprecated.** lead-in as the first line of
the requirement, naming the proposal that removes it and, where committed, the
release or date after which it no longer applies:

```markdown
- **Q3.3.** **Deprecated.** Superseded by proposal `throughput-slo`; applies
  until the 2027.1 release. The API MUST sustain at least 150 requests per
  second under normal load.
```

Where the whole file is deprecated, the marker goes directly beneath the
heading instead. The marker is removed only by deleting the requirement, once
the behavior is gone from production; the retired identifier is never reused.