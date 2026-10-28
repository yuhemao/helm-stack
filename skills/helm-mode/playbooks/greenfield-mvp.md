# Playbook: Greenfield MVP

For a new app or the first usable version.

## Steps

1. **Restate** — Run `restatement`. Do not build yet.
2. **Spec** — Run `write-spec` into `docs/helm-spec.md` (thin L0a). Include stack constraints and non-goals.
3. **Cut** — Run `cut-scope` until P0 fits one weekend of agent work or smaller.
4. **Slice** — Run `vertical-slice`. Pick slice 1 only.
5. **Shape** — Run `shape-before-code` for slice 1 (model gate).
6. **Build** — Run `build-outcome` for slice 1. Decide plumbing under decision-budget.
7. **Eng critique** — Run `eng-critique` (independent / stronger model when available). Fix Must-fix.
8. **Product critique** — Run `product-critique` against the living contract.
9. **Verify** — Run `verify-outcome`. Fix failures inside this slice only (rebuild → eng-critique as needed).
10. **Gate** — `plain-status` for the operator: Waiting on you vs Handled by models. Stop or continue to the next slice only after ACs pass.
