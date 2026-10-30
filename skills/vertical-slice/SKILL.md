---
name: vertical-slice
description: "Break work into vertical slices: thin end-to-end increments with their own observable acceptance. Use when sequencing MVP or a new capability."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Vertical slice

Prefer **vertical slices** over horizontal layers.

## Definition

A valid slice:

- Touches whatever layers are needed to demo one user outcome (UI + logic + data as required)
- Has 1–5 acceptance criteria
- Can be verified without reading code
- Leaves the app demoable (not a half-migrated layer)

## Output

Write a short ordered list into the chat (and optionally a short `## Delivery slices` section in the resolved L0a — not a second authority file):

```text
Slice 1: <outcome> — tier guess: standard (new table) — AC…
Slice 2: <outcome> — tier guess: simple — AC…
```

The tier guess is confirmed (with its trigger) when the slice starts — see `helm-mode/references/acceptance-gate.md`. Slices that would be `high` are good candidates to split so the risky part is small.

## Rules

- Implement **one** slice at a time.
- Do not schedule "all APIs then all UI".
- If a spike is needed to decide UX, label it **spike** and time-box it; spikes are disposable.
