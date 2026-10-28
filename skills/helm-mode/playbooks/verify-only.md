# Playbook: Verify only

Acceptance / demo readiness. No feature work unless a fix is required to finish verification setup.

## Steps

1. **Load truth** — Read `docs/helm-spec.md`. If missing, stop and say so.
2. **Verify** — `verify-outcome` against all P0 ACs (or the operator-named subset).
3. **Critique** — Optional `product-critique` for gaps the checklist missed.
4. **Gate** — Pass/fail table in plain language. List exact click paths for anything the environment could not run.
