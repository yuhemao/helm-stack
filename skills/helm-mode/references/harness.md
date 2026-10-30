# Harness adaptation

`helm-stack` is plain Agent Skills. Behavior should stay the same; mechanics change per host.

## Cursor

- Invoke `/helm-mode` from the skills menu; Option/Alt+Enter may pin it as a custom mode if the host supports that.
- Run `/setup-helm` once to map builder / shaper / eng-critic / product-critic / verifier models.
- Use browser / computer-use tools for verify-outcome when available.
- Subagents: spawn separate agents **only as the slice tier allows** (`simple` 0, `standard` ≤2 per slice, `high` ≤2 per collect round / ≤5 per slice; see `acceptance-gate.md`). Prefer `eng-critic` ≠ `builder` family. Subagents never spawn subagents.

## Claude Code

- Skills install via plugin marketplace or `npx skills add`.
- Commands may be prefixed by the pack name depending on install path.
- `/setup-helm` writes `~/.claude/rules/helm-models.md`.
- Use AskUserQuestion (or equivalent) only for **human gates**.
- Run local commands for verify-outcome; summarize in plain language.

## Codex / other Agent Skills hosts

- Install the `skills/` directories with the host's skills installer.
- If subagents/multi-model are unavailable: simulate shape/critique/dual-try as sequential **blind** passes with an explicit rubric; label Handled by models as "single-model degraded." Same tiers and fix-round budgets apply.
- Resolve L0a via `living-contract.md`; pin with `docs/helm.contract` when adopting a PRD so Codex sessions stay portable.

## Shared invariants

1. Product write-path: one resolved L0a (optional pointer `docs/helm.contract`; optional L1 `docs/helm-now.md`)
2. Max 3 **human** questions per ask, A/B + recommendation
3. Technical uncertainty → model gate, never human interview
4. No success claim without verify-outcome evidence (or honest BLOCKED + click path)
5. eng-critique runs as the slice tier says (`standard`: once; `high`: first round + hard-risk fix diffs; `simple`: optional inline), or skip with reason
6. Premise failure → recover-wrong-turn (rewrite L0a, discard L1/L2, fresh thread)
7. Bounded acceptance: tier with trigger, frozen ACs, collect-then-fix, Must admission, narrow re-verify, fix-round budget, stop on no progress; the parent is the only dispatcher (`acceptance-gate.md`)
