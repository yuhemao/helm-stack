---
name: setup-helm
description: "Configure which models helm-stack uses per role (builder, shaper, eng-critic, product-critic, verifier). Use for /setup-helm, helm model roles, or when model gates need explicit routing."
license: MIT
disable-model-invocation: true
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Setup helm

Write helm's model settings, one model (or alias) per role. This is how **model gates** get stronger models without bothering the operator.

## Where to write

- **Cursor:** `~/.cursor/rules/helm-models.mdc` with `alwaysApply: true`
- **Claude Code:** `~/.claude/rules/helm-models.md`
- **Other harnesses:** `~/.agents/helm-models.md` (skills read it when picking a model)

## Roles

| Role | Used by | Default intent |
|---|---|---|
| `builder` | `build-outcome` | Implement the slice |
| `shaper` | `shape-before-code` | Stronger judgment on structure |
| `eng-critic` | `eng-critique` | Independent engineering review — **prefer different family than builder** |
| `product-critic` | `product-critique` | Product / AC adversarial review |
| `verifier` | `verify-outcome` | Run checks; tool-heavy is fine |

Valid aliases: `inherit-parent`, `auto` (run on the parent chat model).

**Role ≠ agent.** A role says *which model* does that job when it runs. It does **not** mean every role gets its own subagent on every slice. How many independent agents a slice may spawn is set by its risk tier — see `helm-mode/references/acceptance-gate.md` §2. When a tier keeps a job in the parent thread, the parent simply runs that pass itself.

## Steps

1. Detect model slugs this session can pass to subagents. Never write a slug you have not confirmed.
2. If the settings file exists, load it; else start from defaults below.
3. Confirm with the operator (structured questions if available): accept defaults or change roles. Offer detected slugs + `inherit-parent` / `auto`.
4. Write the whole file idempotently.

### Default file shape (Cursor)

```markdown
---
description: helm-stack per-role model choices (overrides skill defaults)
alwaysApply: true
---
# helm model configuration. One line per role. Delete a line to fall back to skill default.
# inherit-parent or auto: role runs on the parent chat model.
# Prefer eng-critic on a different model family than builder when possible.
builder: inherit-parent
shaper: inherit-parent
eng-critic: inherit-parent
product-critic: inherit-parent
verifier: inherit-parent
```

Replace `inherit-parent` with real slugs when the operator wants explicit routing. If the host cannot spawn other models, keep aliases and rely on blind second passes; tell the operator once.

## Confirm

Tell them which file was written and that new sessions pick it up (Cursor / Claude Code). Re-run updates the file.
