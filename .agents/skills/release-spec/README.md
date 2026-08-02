# Release spec

Handles the `ACCEPTED` → `RELEASED` transition.

Checks the implementation is live and merges the specification edits into
the `main` trunk.

## How to invoke

> Release user-session-timeout

> Release 42

## Recommended models

A mid-tier model is sufficient for this skill. The state transition is
procedural, but confirming the implementation is really live requires a bit
more effort.
