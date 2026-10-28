---
name: vertical-slice
description: "Break work into vertical slices: thin end-to-end increments with their own observable acceptance. Use when sequencing MVP or a new capability."
license: MIT
metadata:
  author: helm-stack
  version: "1.0.0"
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

Write a short ordered list into the chat (and optionally a `## Delivery slices` section in `docs/helm-spec.md`):

```text
Slice 1: <outcome> — AC…
Slice 2: <outcome> — AC…
```

## Rules

- Implement **one** slice at a time.
- Do not schedule "all APIs then all UI".
- If a spike is needed to decide UX, label it **spike** and time-box it; spikes are disposable.
