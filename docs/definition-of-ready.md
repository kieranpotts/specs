# Definition of Ready

The *Definition of Ready (DoR)* is a short checklist that confirms a proposal's requirement is well-formed enough to be built. It is applied at a single point in the [proposal lifecycle](../CONTRIBUTING.md#the-proposal-lifecycle): the `PROPOSED` → `ACCEPTED` gate.

Accepting a proposal queues its requirement for implementation, so a proposal MUST NOT be accepted until it meets every criterion below. A proposal can be a good idea and still fail this checklist. When that happens, send it back for refinement rather than accepting it — and rather than rejecting it, which is reserved for ideas the product has decided not to pursue.

The DoR judges _readiness_, not _merit_. Whether the change is worth making is settled in the discussion thread before this gate. What remains here is a mechanical check that the requirement is clear, testable, and buildable.

## The checklist

A proposal is ready to accept when _all_ of the following hold:

- **The requirements are clear and sufficiently unambiguous.** A reader can tell what the system must do without guessing at intent. The proposal uses the project's [ubiquitous language](../specification/context/glossary/), so the same terms mean the same things in the glossary, the model, and every scenario.

- **Functional acceptance criteria are stated as testable Gherkin scenarios.** Each scenario is a concrete, observable behavior that can be checked against the running system. The unhappy paths — empty results, not-found, unauthorized — are covered, too.

- **Quality requirements are stated as measurable thresholds.** Each non-functional requirement names a metric, a target, and the conditions it holds under. A quality that cannot be measured cannot be verified.

- **The stakeholders are known.** It is clear who is affected by the change and whose sign-off the acceptance represents.

- **The work is independent.** The proposal is a single, atomic change that can be implemented without waiting on parallel work — or, where it genuinely depends on other proposals, each of those is itself accepted (or further along) and linked via `Depends on`.

- **The work is implementable in small increments.** The change can be built and shipped incrementally rather than demanding one large, all-or-nothing delivery.

These criteria are deliberately generic, so they apply to any proposal regardless of its subject. The emphasis throughout is on the readiness of the _requirements_ — not on the readiness of a design or an implementation plan, which are out of scope for the specification.

## When a proposal is not ready

If any criterion is unmet, the proposal is not yet ready to accept. Report the specific gap and pause. The author refines the proposal — sharpening an ambiguous requirement, adding the missing scenarios, putting a number on a vague quality — and brings it back through the gate. Refinement keeps the proposal in `PROPOSED` – it does not move it backwards or reject it.

## Related

- [Best practices](./best-practices.md): How to write requirements that pass this checklist: scoping a proposal, writing testable scenarios, and setting measurable thresholds.

- [Contributing guide](../CONTRIBUTING.md): The full proposal lifecycle and the state machine this gate sits within.

- [`accept-spec` skill](../.agents/skills/accept-spec/SKILL.md): The agentic workflow that verifies this checklist when moving a proposal from `PROPOSED` to `ACCEPTED`.

- [TS-1: Requirements Specification](https://github.com/kieranpotts/standards/tree/dev/src/001): The upstream standard these criteria derive from.
