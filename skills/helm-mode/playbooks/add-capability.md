# Playbook: Add capability

For new user-visible behavior on an existing app. Gate rules: `references/acceptance-gate.md`.

## Steps

1. **Restate** — What capability, for whom, why now. Run `restatement` if ambiguous.
2. **Update truth** — Patch the **resolved L0a** only (new ACs + non-goals). No second L0a / no PRD↔helm-spec duplicate. `simple` copy/style changes need no L0a patch.
3. **Slice** — One vertical slice that demos the capability end-to-end.
4. **Tier + AC review + freeze** — Provisional tier with its trigger (§2). `product-critique` on the slice ACs (including "does this break an existing AC?"), re-check the tier once, freeze ACs + envelope smokes chosen from the existing flows this slice touches (§3–4). `simple`: Tier line + ACs only.
5. **Shape** — `shape-before-code` as the tier says.
6. **Build** — `build-outcome` for that slice.
7. **Collect round** — `verify-outcome` (frozen ACs + envelope), then `eng-critique` per tier, same snapshot. Parent triages with Must admission.
8. **Fix rounds** — Checkpoint → one Must batch → `build-outcome` (fix mode) → narrow re-verify. Only while there is progress and budget (§7).
9. **Gate** — `plain-status`. Promote product `Deferred` items and stopped behaviors once into L0a; clear the card. Ask the operator only for a product/UX conflict or a stop option.
