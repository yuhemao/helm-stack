---
name: plain-status
description: "Explain what changed in plain language: Waiting on you (human gates) vs Handled by models (tech already decided). Includes the acceptance-gate exit state and fixed stop options. Every waiting item decidable from the reply alone."
license: MIT
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Plain status

## Required sections

1. **Now true** — user-visible outcomes that work
2. **Not true yet** — remaining P0 gaps
3. **Evidence** — one short block: verify table summary (+ critique summary), the gate's exit state (`PASS` / `STOP: budget` / `STOP: no-progress` / `PENDING-HUMAN` / `partial` / `blocked-on-human`), `Fix rounds n/N`, and the slice's ledger line
4. **Waiting on you** — only human gates (scope, UX/visual taste, conflicting behaviors, money/identity/legal/irreversible, final acceptance click, **stop options**). Each with A/B + recommendation when choosing. If none: say **Nothing waiting on you**.
5. **Handled by models** — one-liners for technical decisions / eng-critique outcomes already taken, including the tier and its trigger (optional if nothing notable)
6. **Assumptions I made** — labeled guess/inferred/measured
7. **Deferred** — one line per item moved out of this slice (and which ones went to L0a)
8. **Next slice** — one sentence

## Stop options (when the gate stopped)

Options, recommendations and the full-autonomy default are defined in `helm-mode/references/acceptance-gate.md` §7. Write them in product language — what users would see, what each choice gets and costs — never as technical diagnosis:

```text
Waiting on you — this slice stopped (<budget used | no progress | security item still open>):
<one sentence: what works, what a user would still hit>
A.  Keep what works (nothing that worked before is broken); the unfinished "<feature>" is hidden for now and noted for a later fix — costs: it stays unavailable
A′. (only if a security / data-loss item is open) Switch off the risky part; the rest stays — costs: <feature> unavailable until fixed
B.  Allow one more fix round — the last round fixed <n of m>
C.  Drop or rewrite this requirement
D.  Rethink the approach — the premise may be wrong
Recommended: <A′ if a security / data-loss item is open | A on the first stop | D if this behavior already stopped once before>
```

Under a full-autonomy grant, do not ask: state which option was applied by default (A, or A′ when a hard-risk item is open) and what they can override.

## After an unattended run

When the operator returns after a full-autonomy grant, open with a **Decided while you were away** list built from each slice card's `Decision trail`: one line per default (what was chosen, what it means for users, how to reverse it). Then the normal sections.
