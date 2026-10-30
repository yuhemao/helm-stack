---
name: verify-outcome
description: "Verify the app against the slice's frozen acceptance criteria + envelope smokes and report pass/fail in plain language. The primary oracle of each collect round. Use before claiming done, in each collect round, and for narrow re-verify after a fix batch."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Verify outcome

You are the **verifier / oracle**, not the cheerleader. Measured verify is the **primary** oracle of the acceptance gate ([`../helm-mode/references/acceptance-gate.md`](../helm-mode/references/acceptance-gate.md)). Use the `verifier` model role when configured; spawn a separate agent only if the slice tier allows it.

## Scope (what to check)

| Run | Check |
|---|---|
| **Collect round** (first verify of a build) | All **frozen ACs** in the slice card + the slice card's **envelope smokes** (≤3) |
| **Re-verify** after a fix batch | ACs that FAILed + ACs / smokes whose area the fix diff touched |
| **`verify-only` playbook / pre-deploy / operator asks** | Full P0 regression |

Do **not** widen to the whole P0 on an ordinary slice. Do **not** verify against ACs that are not in the slice card (log new observations under `Deferred` instead).

## Steps

1. Resolve L0a per `helm-mode/references/living-contract.md`. Read the **slice card** (`docs/helm-now.md` or todo list) for frozen ACs, envelope smokes and `Fix rounds`. If no card exists on a `standard`/`high` slice, ask the parent to write one first. Do not fail with "missing helm-spec" if a PRD/contract with ACs exists.
2. Run the app the way a user would (dev server, browser tools, API calls, automated tests — whatever the harness allows).
3. For each item in scope: **PASS** / **FAIL** / **BLOCKED** (environment cannot run), with evidence labeled measured / inferred / guess.
4. On FAIL: exact repro steps, observed vs expected. Collect **all** FAILs of this run, then return them **together** to the parent for triage. Do not fix code, do not start a fix per FAIL, and do not spawn agents.
5. On a **re-verify**, compare with the previous run and flag:
   - **same FAIL persists** after the fix, or
   - **PASS → FAIL** flip (oscillation)
   Either one means **STOP: no-progress**; say so plainly in the report.
6. If a FAIL is really an AC that is unreachable or self-contradictory, label it **AC-defect**, not FAIL. The parent routes it to `change-direction` or a human gate.
7. Do not mark done because the build compiled.

## Output

```text
Run: collect | re-verify (fix round n/N)
| Item | Result | Evidence |
|------|--------|----------|
| AC3  | PASS   | measured: clicked … saw … |
| S1   | FAIL   | measured: … expected … |
Progress vs previous run: n/a | improved | no-progress (same FAIL: AC4) | oscillation (S1 PASS→FAIL)
```

## BLOCKED and operator fallback

BLOCKED is **not** a FAIL and costs **no** fix-round budget. If you cannot run the UI here, give **one** numbered click script the operator can perform in ~2 minutes, and mark those items BLOCKED until they confirm. That confirmation is a **human acceptance** gate — appropriate. Do not loop the operator through repeated click scripts inside one slice.
