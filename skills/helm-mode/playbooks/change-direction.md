# Playbook: Change direction

For a product premise change while work is in flight — including an AC proven unreachable or contradictory during verify (the **unfreeze** path of the acceptance gate).

## Steps

1. **Freeze work** — Stop implementing features against the old premise. Stop any running collect round / fix round.
2. **Recover posture** — Prefer `recover-wrong-turn` if docs/chat are already sprawling.
3. **Rewrite L0a** — Edit the resolved living contract so it matches the new direction. Mark removed ACs as non-goals.
4. **Invalidate L1/L2** — Delete or fully rewrite `docs/helm-now.md` (including the slice card); discard disposable plans/task lists that assumed the old premise. Do not sync a pyramid.
5. **Reslice** — `vertical-slice` from the new contract. Identify the smallest slice that proves the new direction.
6. **Rebuild loop** — The default quality loop for the new slice: tier + AC review + freeze → [shape] → build → collect round → bounded fix rounds (`references/acceptance-gate.md`). If this is an unfreeze of the same slice, fix rounds already used stay used.
7. **Gate** — `plain-status` with assumptions you dropped. Prefer a fresh thread if context is polluted.
