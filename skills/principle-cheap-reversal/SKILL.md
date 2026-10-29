---
name: principle-cheap-reversal
description: "When a premise fails, revert code, rewrite L0a, discard L1/L2, fresh thread—do not sync a document pyramid. Use when stuck in doc/context mud."
license: MIT
metadata:
  author: helm-stack
  version: "1.1.0"
---

# Cheap reversal

Premise failure is not fixed by synchronizing ten documents.

1. Revert the bad slice to a baseline
2. Rewrite the resolved L0a (PRD or helm-spec)
3. Delete or fully rewrite `docs/helm-now.md` (L1); ignore L2 scratch
4. Fresh thread with L0a + current goal
5. Rebuild

Steer phrase: `apply cheap-reversal`
