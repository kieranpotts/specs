# Accept spec

Handles the `PROPOSED` → `ACCEPTED` transition.

Checks the approval gates and marks the proposal accepted, leaving the
pull request open through implementation.

## How to invoke

> Accept this proposal

> Approve this proposal

> Mark this proposal as accepted

> Accept spec for user session timeout

> Accept 42

## Recommended models

A mid-tier model is sufficient for this skill. The state transition is
procedural, but judging the requirement against the Definition of Ready
requires a bit more effort.
