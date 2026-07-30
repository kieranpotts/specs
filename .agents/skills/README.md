# Agent skills

Skills available to agents in this repository are:

- **[Scaffold spec](./scaffold-spec/):**
  Scaffolds a new draft proposal, ready for the user to complete.
  Sets status to `DRAFT`.

- **[Write spec](./write-spec/):**
  Authors the specification artifacts for a proposal.
  Used during the `DRAFT` state.

- **[Propose spec](./propose-spec/):**
  Handles the `DRAFT` → `PROPOSED` transition.

- **[Accept spec](./accept-spec/):**
  Handles the `PROPOSED` → `ACCEPTED` transition.

- **[Release spec](./release-spec/):**
  Handles the `ACCEPTED` → `RELEASED` transition.

- **[Reject spec](./reject-spec/):**
  Handles the `PROPOSED` → `REJECTED` transition.

- **[Supersede spec](./supersede-spec/):**
  Handles the `RELEASED` → `SUPERSEDED` transition.

## Conventions

Two structural conventions recur across the `SKILL.md` files in this
directory:

- **Transition gates.** Skills that handle a state transition (propose,
  accept, release, reject, supersede) open their gating logic with a
  `## Transition gates: <FROM> → <TO>` heading, e.g. "Transition gates:
  `PROPOSED` → `ACCEPTED`". This section lists the conditions that MUST be
  satisfied before the transition is allowed to proceed.

- **References.** Most skills close with a `## References` section linking
  to related documents the skill depends on or is subordinate to, such as
  the [PR checklist](../../../.github/PULL_REQUEST_TEMPLATE.md) or the
  [Definition of Ready](./write-spec/references/definition-of-ready.md).

## Compatibility

Agent harnesses are converging on the `./.agents/skills/` path for dynamic
retrieval of project-specific skills. This is compatible with the Agent Skills
convention — see https://agentskills.io/.

As of May 2026, OpenAI Codex, GitHub Copilot, Gemini CLI, Google Antigravity,
OpenCode, and Pi will auto-discover these skills, but Claude Code and Cursor
will not.

You will require workarounds for incompatible harnesses. For Claude Code, you
can simply symlink this directory from `.claude/skills/`. Cursor requires more
effort to transpile these skills into its native "rules" format.
