---
name: restatement
description: "Restate the operator's goal and problem in plain language before building. Use when starting helm-mode work, clarifying intent, or when the agent might be solving the wrong problem."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
---

# Restatement

Before writing product code or a long spec, play the request back.

## Output (required sections)

1. **Goal** — what success looks like for a user
2. **Problem** — pain being removed
3. **Users** — who (even if "only me")
4. **In scope / out of scope** — your best current cut
5. **Stack constraints** — named or "unset"
6. **Unknowns** — only those that are product gates

## Rules

- Plain language. No file tours.
- If a critical product unknown exists, ask at most 3 A/B questions with recommendations, then stop for answers.
- If unknowns are technical, **do not ask** — list them as assumptions you will decide later under decision-budget.
- Do not create extra markdown files in this skill; restatement lives in the chat (and feeds `write-spec`).
