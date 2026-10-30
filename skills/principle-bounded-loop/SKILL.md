---
name: principle-bounded-loop
description: "Acceptance is a bounded gate, not an open loop: tier the slice by risk, freeze ACs at build start, collect all findings before fixing, fix in one batch, re-verify only what changed, stop on budget or no progress. Use whenever planning critique/verify work, spawning review agents, or tempted to run another fix→verify round."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Bounded loop

Quality gates stay. Unbounded loops do not. Full rules, tables and templates: [`../helm-mode/references/acceptance-gate.md`](../helm-mode/references/acceptance-gate.md).

1. **Tier** the slice (`simple` / `standard` / `high`) using the named triggers. `high` must cite the trigger it hit; no trigger → not high.
2. **Freeze** the slice ACs + ≤3 envelope smokes in the **slice card** at build start. After freeze, only **hard-risk** findings may add a Must.
3. **Collect, then fix.** Run verify and eng-critique on the **same snapshot** and collect everything before anyone edits code.
4. **Must admission.** A Must needs (a) a frozen AC violated, with evidence, or (b) a hard-risk class (security/authz, data loss, secret leak, irreversible damage) with a concrete failure scenario. Anything else is **Should** → `Deferred`, non-blocking.
5. **One batch.** The parent triages; all admitted Musts go to **one** build.
6. **Re-verify narrowly.** Failed ACs + ACs/smokes the fix diff touched. Eng-critique does not rerun on `standard`.
7. **Stop** at the fix-round budget (`simple` 1, `standard` 2, `high` 2) or on **no-progress** (same FAIL persists, or a PASS flips to FAIL). Stopping is a normal outcome: `plain-status` with product A/B options.
8. **Parent dispatches; subagents report.** No nested fleets, no critic-written patches, no one-agent-per-FAIL.

Tokens buy the **first** high-signal round of proof, not more rounds.

Steer phrase: `apply bounded-loop`
