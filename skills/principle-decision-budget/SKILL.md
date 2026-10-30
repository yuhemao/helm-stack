---
name: principle-decision-budget
description: "Three-tier escalation: human for product/UX gates, stronger models for technical judgment, act on reversible plumbing. Use before AskQuestion or when unsure who should decide."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Decision budget

Classify every urge to ask or pause:

## 1. Human gate (ask the operator)

Only:

1. Scope do / don't
2. Conflicting **user-visible** behaviors or UX / visual taste
3. Money, identity, legal, irreversible data / production blast

Max **3** questions per ask, each **A/B + recommendation**. Never invent shorthand tokens they must memorize.

## 2. Model gate (ask a stronger / independent model — never the human)

Technical forks the operator cannot judge better than a strong model: library choice inside the named stack, data shape, error handling, security posture, maintainability, which of two implementations is sounder.

Decide in the parent with a stronger model role (`shaper` / `shape-before-code`), a blind fresh pass, or a short eng `dual-try`. `eng-critique` runs only inside a collect round on a build snapshot (`helm-mode/references/acceptance-gate.md`) — do not invoke it as a generic model gate.

## 3. Act

Reversible plumbing with enough evidence: decide, act, report in product language (or one-line under "Handled by models" in `plain-status`).

## Hard rule

Never ask the human a question another model would answer better. That is a decision-budget violation.

Steer phrase: `apply decision-budget`
