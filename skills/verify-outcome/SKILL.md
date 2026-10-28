---
name: verify-outcome
description: "Verify the app against observable acceptance criteria and report pass/fail in plain language. Prefer running as verifier role. Use before claiming done or after each slice."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Verify outcome

You are the **verifier / oracle**, not the cheerleader. Prefer the `verifier` model role when configured.

## Steps

1. Load ACs from `docs/helm-spec.md` (or the slice list).
2. Run the app the way a user would (dev server, browser tools, API calls, automated tests — whatever the harness allows). Include a short **regression smoke** of prior P0 happy path when touching an existing app.
3. For each AC: **PASS** / **FAIL** / **BLOCKED** (environment cannot run), with evidence labeled measured/inferred/guess.
4. On FAIL: exact repro steps and observed vs expected. Hand back to build + eng-critique — do not ask the operator for technical diagnosis.
5. Do not mark done because the build compiled.

## Output table

```text
| AC | Result | Evidence |
|----|--------|----------|
| AC1 | PASS | measured: clicked … saw … |
```

## Operator fallback

If you cannot run the UI here, give a numbered click script the operator can perform in ~2 minutes, and mark those ACs BLOCKED until they confirm. That confirmation is a **human acceptance** gate — appropriate.
