# Agent skills

Skills available to agents in this repository are:

- **[Draft spec](./draft-spec/):**
  Scaffolds a new draft proposal, ready for the user to complete.
  Sets status to `DRAFT`.

- **[Write spec](./write-spec/):**
  Authors and edits the specification artifacts for a proposal.
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
