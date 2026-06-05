# Overview

A software requirements specification (SRS) is a living description of what the production system does today. This implementation pairs it with a permanent, chronological log of product decisions, which explains how the current specification came to be the way it is.

Keeping the specification and its changelog side-by-side under the same version control repository makes it easy to maintain both and prevent drift between documentation that specifies the current state of the system and documentation that records the rationale behind that state.

## Living specification

Most requirements documents rot. Written once at the start of a project, they are abandoned as the system evolves past them. Within months they describe a system that no longer exists, and stakeholder trust in the specification deteriorates in response.

This SRS avoids that fate by binding the specification to production. The [specification artifacts](../specification/) on `main` MUST describe how the system behaves for real users right now. A change to those artifacts is not merged to `main` until the corresponding changes in code and configuration are themselves released to production.

The payoff is a single, trustworthy answer to "what does the system do?" New team members, auditors, support staff, and other stakeholders can read it and rely on it.

## Product decision log

A specification alone tells you _what_ the system does, but not _why_. So this repository adds a second artifact alongside it: the [product proposals archive](../proposals/). Every product development proposal — whether that proposal was ultimately implemented or rejected — is preserved in a permanent chronological archive, colocated with the current system specification.

This is the institutional memory of the product. When someone asks "why doesn't the catalog support multiple currencies?" or "why did we reject open, unauthenticated access?", the answer is on record, with the reasoning intact.

Decisions are not silently re-litigated, and the same ground is not covered twice. When stewardship of the product passes to new people, they inherit not just the current state but the reasoning that produced it.

## Separation of product and implementation

Ideally, a software requirements specification would be agnostic of implementation. It should record _what_ the system does and _why_, in the language of the business — but not _how_ it is built, beyond what is strictly necessary to understand the system's functional and non-functional requirements.

Technical decisions – about the technologies, tools, and architectural patterns used to construct, verify, and host the solution – should live separately. A [requests for comments (RFC)](https://github.com/kieranpotts/rfc) repository is a useful companion to the software requirements specification (SRS) that serves this purpose.

Keeping the two apart means the specification survives re-platforming. Rebuild the system on an entirely different stack and its SRS need not change. It also keeps the artifacts better aligned with their target audiences. Free of technical details, the software requirement specification becomes more valuable to business (and other non-technical) stakeholders.

## Alternative methods

Software requirements can be managed using alternative tools such as wikis and issue trackers. These tend to be more leaky that the code repository model. Wikis and static documents describe intent at a point in time but tend to drift out of sync with the running system. Issue trackers are good for work-in-flight but poor as a durable record — closed tickets scatter, and the "current truth" is never assembled in one place.

Executable tests are a good option. But while they carry behavior in a verifiable format, they don't capture motivation, scope, alternatives considered, etc.

The repository model binds the specification to production so it stays accurate, keeps an ordered decision log rather than an opaque edit trail, and holds the prose context that executable tests cannot. It stays accurate, and it does that by adding minimal friction into the software development lifecycle. The specification lives where the work already happens, maintained through the same version control the team already uses. There's no separate tooling, and no parallel workflow to keep things in sync.
