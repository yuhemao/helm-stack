# Playbook: Add capability

For new user-visible behavior on an existing app.

## Steps

1. **Restate** — What capability, for whom, why now. Run `restatement` if ambiguous.
2. **Update truth** — Patch `docs/helm-spec.md` only (new ACs + non-goals). No second doc.
3. **Slice** — One vertical slice that demos the capability end-to-end.
4. **Build** — `build-outcome` for that slice.
5. **Critique** — `product-critique` for regressions against existing ACs.
6. **Verify** — `verify-outcome` for new ACs + a short smoke of prior happy path.
7. **Gate** — `plain-status`. Ask the operator only if a product conflict appeared.
