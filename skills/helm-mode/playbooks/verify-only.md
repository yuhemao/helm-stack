# Playbook: Verify only

Acceptance pass / demo readiness. Do not add features.

## Steps

1. **Load truth** — Read `docs/helm-spec.md`. If missing, stop and say so.
2. **Verify** — Run `verify-outcome` against P0 ACs (+ smoke if asked).
3. **Optional eng pass** — If failures look like regressions from recent code, run `eng-critique` then fix only what verify proved — or stop and recommend **fix-outcome**.
4. **Gate** — `plain-status` with the AC table. Waiting on you = click confirmations only when the environment could not run.
