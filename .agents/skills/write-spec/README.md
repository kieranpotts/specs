# `/write-spec`

Authors and edits the specification content for a proposal, and checks it
against the Definition of Ready.

## What it does

- Places each requirement in the right part of `specification/` (behaviors,
  qualities, context).
- Writes functional requirements as testable Gherkin acceptance criteria,
  covering unhappy paths.
- Writes non-functional requirements as measurable thresholds (metric, target,
  conditions).
- Writes the edits as the final shipped state, in the present tense – not a
  changelog.
- Checks the result against the Definition of Ready.

It is the *content* skill, distinct from the lifecycle skills (`/draft-spec`,
`/propose-spec`, …) which move a proposal through its states. This skill owns
what the specification should contain and how it is written; it is also the
canonical, agent-facing home of the project's content rules and Definition of
Ready. A project tunes its specification standards by editing this skill.

## How to invoke

```
/write-spec
```

Typically invoked while a proposal is in `DRAFT`, after
[`/draft-spec`](../draft-spec/README.md) has scaffolded the branch, document,
and PR, to write the actual specification edits.

## Examples

- `/write-spec`: Helps you author the functional and non-functional requirements
  for the proposal on the current branch, placing each artifact correctly and
  checking it against the Definition of Ready.

- `/write-spec the refund scenarios`: Drafts the Gherkin acceptance criteria for
  a specific part of the requirement.

Once the specification edits are complete and pass the Definition of Ready, use
[`/propose-spec`](../propose-spec/README.md) to mark the PR ready for review.
