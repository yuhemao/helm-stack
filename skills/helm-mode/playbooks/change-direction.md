# Playbook: Change direction

For a product premise change while work is in flight — and the **unfreeze** path when verify proves an AC unreachable or contradictory (`references/acceptance-gate.md` §4).

## Steps

1. **Freeze work** — Stop implementing features against the old premise. Stop any running collect round / fix round.
2. **Human gate if scope moves** — If the change alters scope or a user-visible AC and the operator did not ask for it, ask once (A/B + recommendation). Under a full-autonomy grant: default to "drop the contradictory AC; defer it", and say so.
3. **Recover posture** — Prefer `recover-wrong-turn` if docs/chat are already sprawling.
4. **Rewrite L0a** — Edit the resolved living contract so it matches the new direction. Mark removed ACs as non-goals. On an unfreeze, rewrite only the affected AC lines.
5. **L1/L2** — Premise change: delete or fully rewrite `docs/helm-now.md`; discard disposable plans that assumed the old premise. **Unfreeze of the same slice: keep the slice card**, rewrite only the affected AC lines, re-run AC review inline on those lines, and keep `Fix rounds n/N` and `Stopped behaviors`.
6. **Reslice** — Premise change only: `vertical-slice` from the new contract; the smallest slice that proves the new direction. Behaviors that stopped under the old premise are not re-attempted without the operator (§7 carry-over).
7. **Rebuild loop** — The default quality loop for the (new or reopened) slice: tier + AC review + freeze → [shape] → build → collect round → bounded fix rounds.
8. **Gate** — `plain-status` with assumptions you dropped. Prefer a fresh thread if context is polluted.
