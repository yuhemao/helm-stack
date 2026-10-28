# Harness adaptation

`helm-stack` is plain Agent Skills. Behavior should stay the same; mechanics change per host.

## Cursor

- Invoke `/helm-mode` from the skills menu; Option/Alt+Enter may pin it as a custom mode if the host supports that.
- Prefer Plan mode for multi-file slices when the operator wants to approve the plan before Build — still keep a single living spec.
- Use browser / computer-use tools for verify-outcome when available.
- Subagents: spawn a separate agent for product-critique or dual-try when Task/subagent tools exist.

## Claude Code

- Skills install via plugin marketplace or `npx skills add`.
- Commands may be prefixed by the pack name depending on install path.
- Use AskUserQuestion (or equivalent) for the decision budget.
- Run local commands for verify-outcome; summarize in plain language.

## Codex / other Agent Skills hosts

- Install the `skills/` directories with the host's skills installer.
- If subagents are unavailable, simulate dual-try and critique as sequential blind passes with an explicit rubric.
- Always write `docs/helm-spec.md` so sessions are portable across hosts.

## Shared invariants

1. Living spec path: `docs/helm-spec.md`
2. Max 3 product questions per ask, A/B + recommendation
3. No success claim without verify-outcome evidence (or an honest "could not run here" + operator click path)
4. Premise failure → recover-wrong-turn, not forward patching of context debt
