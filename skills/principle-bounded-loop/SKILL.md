---
name: principle-bounded-loop
description: "Acceptance is a bounded gate, not an open loop: tier the slice by risk, freeze ACs at build start, collect all findings before fixing, fix in one batch, re-verify narrowly, stop on budget or no progress, never re-slice a stopped behavior. Use whenever planning critique/verify work, spawning review agents, or tempted to run another fix→verify round."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Bounded loop

Quality gates stay. Unbounded loops do not. All numbers (agent caps, budgets) and exact definitions live in **one** place: [`../helm-mode/references/acceptance-gate.md`](../helm-mode/references/acceptance-gate.md). Do not restate them elsewhere.

1. **Tier** the slice by named triggers (§2). `high` must cite its trigger. An operator's `simple change` requests a tier; triggers still win.
2. **Freeze** ACs + ≤3 envelope smokes in the slice card at build start (§3–4). After freeze, only **hard-risk** findings may add a Must.
3. **Collect, then fix.** Verify, then eng-critique, on the **same snapshot**; nothing is edited until all findings are in (§6). eng-critique runs only in collect rounds.
4. **Must admission** (§5): a frozen-AC violation with evidence, or a hard-risk class with a concrete failure scenario. Everything else is **Should** → `Deferred`.
5. **One batch** after a checkpoint; **narrow re-verify**: failed ACs + all envelope smokes + what the diff touched (§6).
6. **Stop** at budget or on **no-progress**; on oscillation revert to the checkpoint (§7). Stopping is a normal outcome with fixed product options; a hard-risk hole is switched off, never accepted live.
7. **No cross-slice reset.** A stopped behavior is not re-sliced for a fresh budget without the operator (§7 carry-over).
8. **Parent dispatches; subagents report** (§9). No nested fleets, no critic patches, no one-agent-or-playbook-per-FAIL.

Tokens buy the **first** high-signal round of proof, not more rounds.

Steer phrase: `apply bounded-loop`
