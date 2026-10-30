---
name: helm-mode
description: "Commander entry for AI coding without reading code. Routes playbooks; humans gate product/UX/acceptance; stronger models gate engineering quality. Use for /helm-mode, helm mode, steering a product with agents, or vibe coding as a non-programmer."
license: MIT
disable-model-invocation: true
metadata:
  author: helm-stack
  version: "1.2.0"
  audience: non-programmer-commander
---

# Helm mode

Bundled skills live at `../<name>/SKILL.md` relative to this file. Before using a sub-skill, **read that skill's SKILL.md**. Before citing a principle, **read that principle's SKILL.md**.

This pack is for operators who steer **outcomes**. They may not read diffs. Treat them as product owners with a decision budget — **not** as missing senior engineers, and **not** as a reason to skip engineering rigor.

**Design intent:** keep quality-raising practices; move technical judgment from human experts to **stronger / independent models**. Humans keep requirements, UX/visual taste, and final acceptance.

## Boot (before any playbook step)

1. Read [`references/living-contract.md`](references/living-contract.md) and **resolve L0a**.
2. Existing **PRD** or **spec** with features + acceptance/验收 **counts** — adopt it; pin `docs/helm.contract` if missing.
3. Report `L0a: <path>` once. **Do not** say "missing spec/helm-spec" when a strong PRD/spec exists.
4. Then match a playbook and open its steps.
5. **Per slice, before build:** pick the risk tier (with its trigger), run the AC review, freeze ACs + envelope smokes, and write the **slice card** — see [`references/acceptance-gate.md`](references/acceptance-gate.md).

## Non-negotiables

1. **Thin product authority.** Persist product truth in **one** L0a living contract (resolve path per [`references/living-contract.md`](references/living-contract.md)). Compatible with existing `PRD.md` / `spec.md` / `helm-spec.md` — filename does not matter. Optional `docs/helm-now.md` (L1). Technical truth in code + runnable checks (L0b). **Never** duplicate PRD↔spec as two authorities. See **one-source-of-truth**.
2. **Decision budget (three tiers).** **Human gate:** product scope, conflicting user-visible/UX choices, money/identity/legal/irreversible. **Model gate:** technical judgment → stronger/independent models (`shape-before-code`, `eng-critique`, eng `dual-try`). **Act:** reversible plumbing with evidence. Max **3** human questions per ask, each **A/B + recommendation**. Never ask a question another model would answer better (**model-not-human-for-tech**).
3. **Observable acceptance.** "Done" means a human (or scripted driver) can exercise a checklist. Compiles / "looks good" is not done. Use **verify-outcome** before claiming success.
4. **Vertical slices.** Thin end-to-end increments; each ends in acceptance the operator can judge without reading code.
5. **Cheap reversal.** Premise wrong → **recover-wrong-turn**: revert slice, rewrite L0a, discard L1/L2, fresh thread. Do not sync ten docs.
6. **Tokens for first-round proof.** Extra tokens buy one high-signal round of oracles (AC review, verify, bounded eng-critique, dual-try when warranted) — not planning prose, tech interviews with the operator, or unbounded fix→verify loops.
7. **Bounded acceptance.** Every slice runs the gate in [`references/acceptance-gate.md`](references/acceptance-gate.md): risk tier, frozen ACs, collect-then-fix, Must admission, narrow re-verify, fix-round budget, stop on no progress. See **bounded-loop**.
8. **Product not plumbing.** Operator replies stay in outcomes and gates. Engineering work still happens via model gates; summarize under Handled by models when useful.
9. **Precise terms.** Prefer [`references/terminology.md`](references/terminology.md).

## Principles index

Read the leaf skill when you apply it. Cite only principles you actually read this session.

| Principle | When |
|---|---|
| [`principle-one-source-of-truth`](../principle-one-source-of-truth/SKILL.md) | Docs proliferate; tempted to add a second authority |
| [`principle-decision-budget`](../principle-decision-budget/SKILL.md) | About to AskQuestion; unsure human vs model vs act |
| [`principle-model-not-human-for-tech`](../principle-model-not-human-for-tech/SKILL.md) | About to ask the operator a technical question |
| [`principle-observable-acceptance`](../principle-observable-acceptance/SKILL.md) | Writing "done", writing AC, verifying |
| [`principle-vertical-slice`](../principle-vertical-slice/SKILL.md) | Breaking work down; sequencing delivery |
| [`principle-cheap-reversal`](../principle-cheap-reversal/SKILL.md) | Premise wrong; scope thrash; doc/context swamp |
| [`principle-token-for-proof`](../principle-token-for-proof/SKILL.md) | Choosing where to spend extra model calls |
| [`principle-bounded-loop`](../principle-bounded-loop/SKILL.md) | Planning critique/verify; spawning review agents; tempted to run another fix→verify round |
| [`principle-product-not-plumbing`](../principle-product-not-plumbing/SKILL.md) | Writing any reply to the operator |

Agent-internal engineering reminders (not commander vocabulary): [`references/eng-principles.md`](references/eng-principles.md).

## Sub-skill router

Load these by reading their SKILL.md when a playbook step needs them. Do not make the operator type their names.

| Need | Skill |
|---|---|
| Confirm goal/problem before building | [`restatement`](../restatement/SKILL.md) |
| Create/refresh thin living product contract | [`write-spec`](../write-spec/SKILL.md) |
| Cut MVP; name non-goals | [`cut-scope`](../cut-scope/SKILL.md) |
| Split into click-testable increments | [`vertical-slice`](../vertical-slice/SKILL.md) |
| Settle data/API shape before a non-trivial slice | [`shape-before-code`](../shape-before-code/SKILL.md) |
| Implement the current slice | [`build-outcome`](../build-outcome/SKILL.md) |
| Independent engineering adversarial review | [`eng-critique`](../eng-critique/SKILL.md) |
| AC review vs living contract (once, before build) | [`product-critique`](../product-critique/SKILL.md) |
| Run / walk acceptance; plain pass/fail | [`verify-outcome`](../verify-outcome/SKILL.md) |
| Tier, freeze, triage, budget, exit states | [`references/acceptance-gate.md`](references/acceptance-gate.md) |
| Two short attempts (UX or eng fork) | [`dual-try`](../dual-try/SKILL.md) |
| Wrong turn / doc swamp / bad premise | [`recover-wrong-turn`](../recover-wrong-turn/SKILL.md) |
| Catch the operator up in plain words | [`plain-status`](../plain-status/SKILL.md) |
| Configure model roles for gates | [`setup-helm`](../setup-helm/SKILL.md) |
| Orientation only (no work) | [`helm-help`](../helm-help/SKILL.md) |

## Autonomy

**Just do it** for reversible work inside the named stack and current slice.

**Always pause** (ask or state a default and wait if irreversible) for: production deploy, deleting real user data, billing, force-push to shared main, messaging real customers.

**Full-autonomy grant** ("don't stop", "I'm going to bed", "run until the checklist passes"): decide covered calls (including model gates), act, keep a short decision trail. For calls only the operator can make, apply a **default**, say what you assumed, and say what they can override in plain words — never invent shorthand tokens.

## Playbooks

Open a todo list whose first items are the matched playbook's steps (copy verbatim from the playbook file). Keep skipped steps as `skip: <reason>`.

Match the operator's ask to one playbook and open `playbooks/<file>.md`:

| Playbook | File | For |
|---|---|---|
| Greenfield MVP | [`playbooks/greenfield-mvp.md`](playbooks/greenfield-mvp.md) | New app / first usable version |
| Add capability | [`playbooks/add-capability.md`](playbooks/add-capability.md) | New user-visible behavior on an existing app |
| Fix outcome | [`playbooks/fix-outcome.md`](playbooks/fix-outcome.md) | Something fails an acceptance check or user flow |
| Change direction | [`playbooks/change-direction.md`](playbooks/change-direction.md) | Spec/product premise changed mid-flight |
| Spec only | [`playbooks/spec-only.md`](playbooks/spec-only.md) | Clarify and lock the living contract; do not build yet |
| Verify only | [`playbooks/verify-only.md`](playbooks/verify-only.md) | Acceptance pass / demo readiness |
| Recover | [`playbooks/recover.md`](playbooks/recover.md) | Doc swamp, wrong premise, unmaintainable context |
| Dual path | [`playbooks/dual-path.md`](playbooks/dual-path.md) | High uncertainty; try two thin paths (UX or eng) |

If nothing fits, design a **short** bespoke playbook (max 10 steps) that still ends in observable acceptance and still runs the acceptance gate for its tier. Prefer reusing sub-skills over inventing ceremony.

## Default quality loop (every slice; tier sets the weight)

```text
tier + AC review (product-critique) → freeze (slice card)
→ [shape-before-code] → build-outcome
→ collect round: verify-outcome ∥ eng-critique   (same snapshot; no edits in between)
→ parent triage (Must admission) → one fix batch → narrow re-verify
→ PASS | STOP: budget | STOP: no-progress → plain-status
```

| Tier | Runs | Independent agents | Fix rounds |
|---|---|---|---|
| `simple` | inline AC check → build → verify (parent thread) | 0 | 1 |
| `standard` | AC review → [shape] → build → verify ∥ eng-critique (first round only) | ≤2 per slice | 2 |
| `high` | AC review → shape → build → verify ∥ eng-critique; eng re-review only of fix diffs touching hard-risk code | ≤2 per round, ≤5 per slice | 2 |

Tier triggers, slice card, Must admission, re-verify scope and stop options: [`references/acceptance-gate.md`](references/acceptance-gate.md). `high` must name its trigger. Skipping a step the tier requires needs `skip: <reason>`.

**Parent is the only dispatcher.** Subagents report findings; they do not spawn agents or fix code (except the builder executing the Must batch it was handed). Never one agent per FAIL. Never another round past budget without the operator choosing it.

## Reply shape

Write for the operator:

1. **User-visible outcome**
2. **Checklist** (observable acceptance for this slice)
3. **Waiting on you** (human gates only; each decidable from the reply)
4. **Handled by models** (optional one-liners for technical decisions already taken)
5. **Assumptions** (labeled measured / inferred / guess)

No long implementation tours. No asking them to read diffs.

## Harness notes

- **Subagents / models:** spawn independent agents **only as the slice tier allows** (`simple` 0, `standard` ≤2, `high` ≤2 per round). `/setup-helm` roles choose *which model* does a job; they are not a mandate to spawn. No nested fleets. If only one model exists: blind second pass with rubric inside the same budget; say so under Handled by models.
- **Questions:** structured question tool when present; else numbered A/B in chat.
- **Verification:** run the app / tests / browser tools when possible; otherwise honest BLOCKED + click path.
- **Persistence:** resolve and keep one L0a path (`docs/helm.contract` recommended). Do not claim "missing spec" when a PRD with acceptance already exists — adopt it. Never duplicate PRD into a second helm-spec body.

More: [`references/acceptance-gate.md`](references/acceptance-gate.md), [`references/living-contract.md`](references/living-contract.md), [`references/harness.md`](references/harness.md), [`references/prompting.md`](references/prompting.md), [`references/terminology.md`](references/terminology.md), [`references/eng-principles.md`](references/eng-principles.md).
