# Benefits

A software requirements specification (SRS) is two things at once: a **living description** of what the production system does today, and a **permanent decision log** of how it came to be that way. This repository keeps both in version control, next to each other, so that the current state of the system and the rationale behind it never drift apart.

## Why a living specification

Most requirements documents rot. They are written once, at the start of a project, and then abandoned as the system evolves past them. Within months they describe a system that no longer exists, and nobody trusts them.

This SRS avoids that fate by binding the specification to production. The [`specification/`](../specification/) artifacts on `main` MUST describe the system as it actually behaves for real users right now. A change to the specification is not merged until the corresponding change is live in production. The specification therefore stays current by construction — it is never aspirational, always descriptive of the present.

The payoff is a single, trustworthy answer to "what does the system do?" — in business terms, independent of any particular implementation. New team members, auditors, support staff, and stakeholders can read it and rely on it.

## Why a permanent decision log

The specification tells you _what_ the system does. The [`proposals/`](../proposals/) archive tells you _why_. Every change — and every change that was considered and **rejected** — is preserved as a proposal document recording its motivation, the alternatives weighed, and the trade-offs accepted.

This is the institutional memory of the product. When someone asks "why doesn't the catalog support multiple currencies?" or "why did we reject open, unauthenticated access?", the answer is on record, with the reasoning intact. Decisions are not silently re-litigated, and the same ground is not covered twice. When stewardship of the product passes to new people, they inherit not just the current state but the full history of reasoning that produced it.

## Separation of product and implementation

This repository is deliberately implementation-agnostic. It records _what_ the system does and _why_, in the language of the business — not _how_ it is built. Technical decisions live in the companion [RFC repository](https://github.com/kieranpotts/rfc).

Keeping the two apart means the specification survives re-platforming: if the system were rebuilt on an entirely different technology stack, its SRS would not need to change. It also keeps the right people in charge of the right decisions — product managers own the requirements; technical stakeholders own the architecture.

## How it compares

- **Versus a static requirements document (or a wiki):** those describe intent at a point in time and quickly fall out of sync with the running system. The SRS is bound to production, so it stays accurate, and its history is a structured log rather than an opaque edit trail.

- **Versus tracking requirements only as tickets:** issue trackers are excellent for work in flight but poor as a durable record. Closed tickets scatter; the "current truth" is never assembled in one place. The SRS gives you a coherent, always-current description plus an ordered decision log.

- **Versus capturing requirements only in tests:** executable acceptance tests are invaluable, and this SRS expresses functional requirements as [Gherkin](https://cucumber.io/docs/gherkin/) scenarios precisely so they map cleanly onto tests. But tests alone do not carry motivation, scope, alternatives, or non-functional intent. The SRS holds the prose context that tests cannot.

## When it is worth it

Like any process, an SRS adds friction, and that friction has to earn its keep. It pays off most where requirements are non-trivial, long-lived, and shared across many stakeholders — where the cost of a forgotten decision or a stale requirement is high. For a throwaway prototype, it is overkill. The goal is _just enough_ structure to keep the specification trustworthy and the reasoning recoverable, and no more.
