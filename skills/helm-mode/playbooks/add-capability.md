# Playbook: Add capability

For new user-visible behavior on an existing app.

## Steps

1. **Restate** — What capability, for whom, why now. Run `restatement` if ambiguous.
2. **Update truth** — Patch the **resolved L0a** only (new ACs + non-goals). No second L0a / no PRD↔helm-spec duplicate.
3. **Slice** — One vertical slice that demos the capability end-to-end.
4. **Tier + AC review + freeze** — Pick the tier with its trigger. Run `product-critique` on the slice ACs (including "does this break an existing AC?"). Freeze ACs + ≤3 envelope smokes chosen from the existing flows this slice touches. Write the slice card in `docs/helm-now.md` (`references/acceptance-gate.md`).
5. **Shape** — `shape-before-code` per tier (`simple`: skip).
6. **Build** — `build-outcome` for that slice.
7. **Collect round** — `verify-outcome` (frozen ACs + envelope smokes) ∥ `eng-critique` per tier, same snapshot. Parent triages with Must admission.
8. **Fix rounds** — One Must batch → `build-outcome` (fix mode) → narrow re-verify. Within budget; stop on budget or no-progress.
9. **Gate** — `plain-status`. Promote product `Deferred` items once into L0a; clear the card. Ask the operator only for a product/UX conflict or a stop option.
