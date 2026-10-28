---
name: principle-model-not-human-for-tech
description: "Route technical judgment to stronger or independent models, not to a non-technical operator. Use when about to ask a plumbing, design, or code-quality question."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Model not human for tech

helm-stack lowers the **human** bar by raising **model** control — it does **not** delete quality practices.

If the question is about correctness, architecture shape, security, performance tradeoffs inside the stack, or "which implementation is better," escalate to:

- a stronger model role (`shaper`, `eng-critic` via `/setup-helm`), or
- a blind second pass with an explicit rubric

Do **not** escalate that question to the operator. Report outcomes in product language; keep engineering detail in model-to-model briefs and short L1 notes if needed.

Steer phrase: `apply model-not-human-for-tech`
