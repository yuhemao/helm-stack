# Playbook: Greenfield MVP

For a new app or the first usable version.

## Steps

1. **Restate** — Run `restatement`. Do not build yet.
2. **Spec** — Run `write-spec` into `docs/helm-spec.md`. Include stack constraints and non-goals.
3. **Cut** — Run `cut-scope` until P0 fits one weekend of agent work or smaller.
4. **Slice** — Run `vertical-slice`. Pick slice 1 only.
5. **Build** — Run `build-outcome` for slice 1. Decide plumbing under decision-budget.
6. **Critique** — Run `product-critique` against the living spec (blind to cheerleading).
7. **Verify** — Run `verify-outcome`. Fix failures inside this slice only.
8. **Gate** — `plain-status` for the operator: what works, checklist, waiting-on-you. Stop or continue to the next slice only after ACs pass.
