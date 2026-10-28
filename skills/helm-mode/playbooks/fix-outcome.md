# Playbook: Fix outcome

For a broken user flow or failing acceptance check.

## Steps

1. **Reproduce** — Restate the failing observable (what they did, what they saw, what should happen).
2. **Anchor** — Diff the failure against `docs/helm-spec.md` ACs. If the AC is wrong, this is **change-direction**, not a bug fix.
3. **Smallest fix** — `build-outcome` aimed only at restoring the AC. No drive-by features.
4. **Verify** — `verify-outcome` on the failing AC + nearby regression smoke.
5. **Gate** — Report measured evidence. If still failing, one more fix loop; then escalate with options A/B.
