---
name: verify-outcome
description: "Verify the app against observable acceptance criteria and report pass/fail in plain language. Use before claiming done, before demos, or after each slice."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
---

# Verify outcome

You are the **verifier / oracle**, not the cheerleader.

## Steps

1. Load ACs from `docs/helm-spec.md` (or the slice list).
2. Run the app the way a user would (dev server, browser tools, API calls, automated tests — whatever the harness allows).
3. For each AC: **PASS** / **FAIL** / **BLOCKED** (environment cannot run), with evidence labeled measured/inferred/guess.
4. On FAIL: include exact steps to reproduce and the observed vs expected result.
5. Do not mark done because the build compiled.

## Output table

```text
| AC | Result | Evidence |
|----|--------|----------|
| AC1 | PASS | measured: clicked … saw … |
```

## Operator fallback

If you cannot run the UI here, give a numbered click script the operator can perform in 2 minutes, and mark those ACs BLOCKED until they confirm.
