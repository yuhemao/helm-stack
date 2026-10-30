# Playbook: Verify only

Acceptance pass / demo readiness. Do not add features and do not fix code here. This is the normal place for a **full P0 regression**.

## Steps

1. **Load truth** — Resolve L0a (`references/living-contract.md`). If none, stop and say so — but adopt an existing PRD with ACs instead of demanding `helm-spec.md` by name.
2. **Verify** — Run `verify-outcome` against all P0 ACs (full regression scope).
3. **Optional eng pass** — If failures look like regressions from recent code, one `eng-critique` on the current snapshot may classify likely causes (findings only, no fixes). This is the run's single collect round.
4. **Gate** — `plain-status` with the AC table. Failures → recommend **one** `fix-outcome` for the failing ACs that carry **no** STOP / A′ mark (one card, one budget). List stopped and switched-off items separately as operator choices (`references/acceptance-gate.md` §7 carry-over). Under a full-autonomy grant, start that fix-outcome only once per session. Waiting on you = click confirmations only when the environment could not run.
