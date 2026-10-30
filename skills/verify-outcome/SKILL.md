---
name: verify-outcome
description: "Verify the app against the slice's frozen acceptance criteria + envelope smokes and report pass/fail in plain language. The primary oracle of each collect round. Use before claiming done, in each collect round, and for narrow re-verify after a fix batch."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Verify outcome

You are the **verifier / oracle**, not the cheerleader. Measured verify is the **primary** oracle of the acceptance gate ([`../helm-mode/references/acceptance-gate.md`](../helm-mode/references/acceptance-gate.md); tier rules in §2). Use the `verifier` model role when configured; the **parent** decides whether a separate agent runs this, within the tier's cap; this skill's agent never spawns agents.

## Scope (what to check)

| Run | Check |
|---|---|
| **Collect round** (first verify of a build) | All **frozen ACs** in the slice card + all **envelope smokes** |
| **Re-verify** after a fix batch | FAILed ACs + the measured repro of every Must in the batch + **all envelope smokes (always)** + ACs that exercise any file in the changed-file list |
| **`verify-only` playbook / pre-deploy / operator asks** | Full P0 regression |

Do **not** widen to the whole P0 on an ordinary slice. Do **not** add new product ACs: log new product observations as non-blocking **Product notes** (→ `Deferred`). **Exception:** a hard-risk observation (security / authz, data loss, secret leak, irreversible) is reported as a **hard-risk finding** with a concrete scenario, for parent triage — never silently deferred.

## Steps

1. Resolve L0a per `helm-mode/references/living-contract.md`. Read the **slice card** (pasted in your brief, or `docs/helm-now.md`) for frozen ACs, envelope smokes and `Fix rounds`. No card on a `standard`/`high` slice → ask the parent to write one first. Do not fail with "missing helm-spec" if a PRD/contract with ACs exists.
2. Run the app the way a user would (dev server, browser tools, API calls, automated tests — whatever the harness allows). For delete / clear / overwrite behaviors, run the check only on a disposable copy or seeded database — never on the operator's real data; if no safe copy can be made, mark BLOCKED and give a click script.
3. For each item in scope: **PASS** / **FAIL** / **BLOCKED** (environment cannot run), with evidence labeled measured / inferred / guess. For each FAIL record **observed vs expected** precisely — the parent compares it across rounds.
4. Collect **all** FAILs of this run, then return them **together** to the parent for triage. Do not fix code, do not start a fix per FAIL, do not spawn agents.
5. On a **re-verify**, compare with the previous run item by item: `FAIL→PASS`, `PASS→FAIL`, `FAIL→FAIL (same observed)`, `FAIL→FAIL (new observed)`. Report the progress verdict using the definitions in acceptance-gate §7 (progress / no-progress / oscillation).
6. If an item is really an AC that is unreachable or self-contradictory, label it **AC-defect**, not FAIL. The parent handles it per acceptance-gate §4 (unfreeze).
7. Do not mark done because the build compiled.

## Output

```text
Run: collect | re-verify (fix round n/N)
| Item | Result | Evidence |
|------|--------|----------|
| AC3  | PASS   | measured: clicked … saw … |
| S1   | FAIL   | measured: observed … / expected … |
Progress vs previous run: n/a | progress (AC4 FAIL→PASS) | no-progress (AC4 same observed) | oscillation (S1 PASS→FAIL)
Hard-risk findings: none | <scenario>
Product notes (non-blocking → Deferred): …
```

## BLOCKED and operator fallback

BLOCKED is **not** a FAIL. If you cannot run the UI here, give **one** numbered click script the operator can perform in ~2 minutes, and mark those items BLOCKED until they confirm. That confirmation is a **human acceptance** gate. Do not loop the operator through repeated click scripts inside one slice. (A fix round whose re-verify is BLOCKED still counts as used — acceptance-gate §6.)
