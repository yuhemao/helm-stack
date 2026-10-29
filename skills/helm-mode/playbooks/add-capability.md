# Playbook: Add capability

For new user-visible behavior on an existing app.

## Steps

1. **Restate** — What capability, for whom, why now. Run `restatement` if ambiguous.
2. **Update truth** — Patch the **resolved L0a** only (new ACs + non-goals). No second L0a / no PRD↔helm-spec duplicate. Refresh or clear `docs/helm-now.md` as needed.
3. **Slice** — One vertical slice that demos the capability end-to-end.
4. **Shape** — `shape-before-code` (skip only if trivial with reason).
5. **Build** — `build-outcome` for that slice.
6. **Eng critique** — `eng-critique`; fix Must-fix.
7. **Product critique** — `product-critique` for regressions against existing ACs.
8. **Verify** — `verify-outcome` for new ACs + short smoke of prior happy path.
9. **Gate** — `plain-status`. Ask the operator only if a product/UX conflict appeared.
