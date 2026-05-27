# Advance proposal

Transitions a proposal from its current lifecycle state to the next permitted state.

## What it does

Verifies that all checklist gates for the target state are satisfied, updates the `Status` field and `Last updated` date in the proposal document, applies the matching GitHub label to the PR, assigns the sequential ID on acceptance, and reverts specification edits on rejection.

## How to invoke

```
/advance-proposal
```

Optionally name the proposal and target state:

```
/advance-proposal 0003-user-session-timeout accepted
```

## Examples

- `/advance-proposal` — agent identifies the current proposal from context and prompts for the target state.
- `/advance-proposal user-session-timeout proposed` — advances the named proposal to `#proposed` after verifying gates.
- `/advance-proposal 0003-user-session-timeout released` — marks as released once the implementation is live.
