---
name: shape-before-code
description: "Settle data shape, boundaries, and illegal states before implementing a non-trivial slice. Prefer a stronger model; optional short dual sketch. Use before build-outcome when the slice crosses modules or invents structure."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Shape before code

For non-trivial slices, **name the shape before writing feature logic**.

## Do

1. Read `docs/helm-spec.md` ACs for this slice (and `docs/helm-now.md` if present).
2. State in short form: entities / states, boundaries (API, DB, auth), what is illegal, what is trusted inside.
3. If two shapes are plausible and costly to reverse: run a **short** eng dual sketch (same shared ACs) and pick via model judgment or `eng-critique` — **do not ask the operator**.
4. Optionally write 3–5 one-liners into `docs/helm-now.md` under eng decisions. Do not open `architecture.md`.

## Do not

- Produce a long design novel for the operator
- Ask the human which ORM, folder layout, or error-type style to use
- Skip this on boundary-crossing or greenfield structure work without `skip: <reason>`

Prefer the `shaper` model role when `/setup-helm` (or equivalent) is configured.
