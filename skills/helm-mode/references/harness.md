# Harness adaptation

`helm-stack` is plain Agent Skills. Behavior should stay the same; mechanics change per host.

## Cursor

- Invoke `/helm-mode` from the skills menu; Option/Alt+Enter may pin it as a custom mode if the host supports that.
- Run `/setup-helm` once to map builder / shaper / eng-critic / product-critic / verifier models.
- Use browser / computer-use tools for verify-outcome when available.
- Subagents: spawn separate agents for `shape-before-code`, `eng-critique`, `product-critique`, and eng `dual-try` when Task/subagent tools exist. Prefer `eng-critic` ≠ `builder` family.

## Claude Code

- Skills install via plugin marketplace or `npx skills add`.
- Commands may be prefixed by the pack name depending on install path.
- `/setup-helm` writes `~/.claude/rules/helm-models.md`.
- Use AskUserQuestion (or equivalent) only for **human gates**.
- Run local commands for verify-outcome; summarize in plain language.

## Codex / other Agent Skills hosts

- Install the `skills/` directories with the host's skills installer.
- If subagents/multi-model are unavailable: simulate shape/critique/dual-try as sequential **blind** passes with an explicit rubric; label Handled by models as "single-model degraded."
- Always write `docs/helm-spec.md` so sessions are portable across hosts.

## Shared invariants

1. Product write-path: `docs/helm-spec.md` (optional L1: `docs/helm-now.md`)
2. Max 3 **human** questions per ask, A/B + recommendation
3. Technical uncertainty → model gate, never human interview
4. No success claim without verify-outcome evidence (or honest BLOCKED + click path)
5. Non-trivial slices run eng-critique (or skip with reason)
6. Premise failure → recover-wrong-turn (rewrite L0a, discard L1/L2, fresh thread)
