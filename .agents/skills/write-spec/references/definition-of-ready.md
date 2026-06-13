# Definition of Ready

This is the canonical, agent-facing Definition of Ready (DoR) for the software requirements specification. It is the single source of the readiness checklist: the [`write-spec`](../SKILL.md) skill authors specification content to satisfy it, and the [`accept-spec`](../../accept-spec/SKILL.md) skill verifies it at the `PROPOSED` → `ACCEPTED` gate.

The DoR judges *readiness*, not *merit*. Whether a change is worth making is settled in the proposal's discussion thread, before this gate. What remains here is a mechanical check that the requirement is clear, testable, and buildable.

## The checklist

A proposal's specification edits are ready when *all* of the following hold:

- **The requirements are clear and sufficiently unambiguous.** A reader can tell what the system must do without guessing at intent. The same terms mean the same things in the glossary, the model, and every scenario – using the project's ubiquitous language ([`specification/context/glossary/`](../../../../specification/context/glossary/)).

- **Functional acceptance criteria are stated as testable Gherkin scenarios.** Each is a concrete, observable behavior checkable against the running system. The unhappy paths – empty results, not-found, unauthorized – are covered, too.

- **Quality requirements are stated as measurable thresholds.** Each non-functional requirement names a metric, a target, and the conditions it holds under. A quality that cannot be measured cannot be verified.

- **The stakeholders are known.** It is clear who is affected by the change and whose sign-off the acceptance represents.

- **The work is independent.** A single, atomic change implementable without waiting on parallel work – or, where it genuinely depends on other proposals, each of those is itself accepted (or further along) and linked via `Depends on`.

- **The work is implementable in small increments.** Buildable and shippable incrementally, not one large all-or-nothing delivery.

These criteria are deliberately generic, so they apply to any proposal regardless of its subject. The emphasis throughout is on the readiness of the *requirements* – not on the readiness of a design or an implementation plan, which are out of scope for the specification.

## When a proposal is not ready

If any criterion is unmet, the proposal is not yet ready to accept. Report the specific gap and pause. The author refines the proposal – sharpening an ambiguous requirement, adding the missing scenarios, putting a number on a vague quality – and brings it back through the gate. Refinement keeps the proposal in `PROPOSED`; it does not move it backwards or reject it. A proposal can be a good idea and still fail this checklist; when that happens, send it back for refinement rather than accepting it – and rather than rejecting it, which is reserved for ideas the product has decided not to pursue.

## Related

- [`write-spec`](../SKILL.md): Authors specification content to meet this checklist.
- [`accept-spec`](../../accept-spec/SKILL.md): Verifies this checklist at the `PROPOSED` → `ACCEPTED` gate.
- [Best practices](../../../../docs/best-practices.md) and [Definition of Ready (human guide)](../../../../docs/definition-of-ready.md): Human-readable rationale.
- [TS-1: Requirements Specification](https://github.com/kieranpotts/standards/tree/dev/src/001): The upstream standard these criteria derive from.
