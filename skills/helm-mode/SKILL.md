---
name: helm-mode
description: "Commander entry point for AI coding without reading code. One main command that routes playbooks and loads sub-skills. Use for /helm-mode, helm mode, steering a product with agents, vibe coding as a non-programmer, or when the user wants requirements/scope/acceptance control while the agent owns implementation."
license: MIT
disable-model-invocation: true
metadata:
  author: helm-stack
  version: "1.0.0"
  audience: non-programmer-commander
---

# Helm mode

Bundled skills live at `../<name>/SKILL.md` relative to this file. Before using a sub-skill, **read that skill's SKILL.md**. Before citing a principle, **read that principle's SKILL.md**.

This pack is for operators who steer **outcomes**. They may not read diffs. Treat them as product owners with a decision budget, not as missing senior engineers.

## Non-negotiables

1. **One living truth.** Persist product truth in `docs/helm-spec.md` (create the folder if needed). Do not spawn parallel `architecture.md` / `tasks-v3.md` / issue trees unless the operator explicitly asks. Derived plans are disposable; the spec is not.
2. **Decision budget.** Classify every urge to ask the human. Technical forks, library choice inside the named stack, folder layout, naming, copy micro-tweaks: **decide, act, report**. Ask only for **product scope**, **conflicting user-visible behaviors**, or **money / identity / legal / irreversible data** issues. Max **3** questions per ask, each as **A/B + your recommendation**. Never ask a question another model could answer better than this operator.
3. **Observable acceptance.** "Done" means a human (or a scripted driver) can exercise a checklist and see the result. Compiles / "looks good" / self-praise is not done. Use the **verify-outcome** skill before claiming success.
4. **Vertical slices.** Prefer thin end-to-end increments over layered "finish backend then frontend". Each slice ends in acceptance the operator can judge without reading code.
5. **Cheap reversal.** If an early premise was wrong, do **not** patch a document pyramid. Use **recover-wrong-turn**: revert the slice, edit the spec, fresh thread, rebuild. Long chats that "accommodate" a bad premise are failure modes.
6. **Tokens for proof.** Extra tokens go to independent critique, dual attempts, and runnable verification — not to more planning prose or clarifying interviews.
7. **Product not plumbing.** Frame replies for the operator: what a user can do now, what is blocked, what needs a product call. Hide implementation narration unless they ask.
8. **Precise terms.** When steering work, prefer the glossary in [`references/terminology.md`](references/terminology.md). One exact term beats a fuzzy paragraph.

## Principles index

Read the leaf skill when you apply it. Cite only principles you actually read this session.

| Principle | When |
|---|---|
| [`principle-one-source-of-truth`](../principle-one-source-of-truth/SKILL.md) | Tempted to add a second planning doc; syncing drifted docs |
| [`principle-decision-budget`](../principle-decision-budget/SKILL.md) | About to AskQuestion; unsure whether to bother the operator |
| [`principle-observable-acceptance`](../principle-observable-acceptance/SKILL.md) | Writing "done", writing AC, verifying |
| [`principle-vertical-slice`](../principle-vertical-slice/SKILL.md) | Breaking work down; sequencing delivery |
| [`principle-cheap-reversal`](../principle-cheap-reversal/SKILL.md) | Premise wrong; scope thrash; doc/context swamp |
| [`principle-token-for-proof`](../principle-token-for-proof/SKILL.md) | Choosing where to spend extra model calls |
| [`principle-product-not-plumbing`](../principle-product-not-plumbing/SKILL.md) | Writing any reply to the operator |

## Sub-skill router

Load these by reading their SKILL.md when a playbook step needs them. Do not make the operator type their names.

| Need | Skill |
|---|---|
| Confirm you understood goal/problem before building | [`restatement`](../restatement/SKILL.md) |
| Create or refresh the living spec | [`write-spec`](../write-spec/SKILL.md) |
| Cut MVP; name non-goals | [`cut-scope`](../cut-scope/SKILL.md) |
| Split into click-testable increments | [`vertical-slice`](../vertical-slice/SKILL.md) |
| Implement the current slice | [`build-outcome`](../build-outcome/SKILL.md) |
| Run / walk acceptance; plain pass/fail | [`verify-outcome`](../verify-outcome/SKILL.md) |
| Adversarial product check vs spec | [`product-critique`](../product-critique/SKILL.md) |
| Two short attempts; keep the better outcome | [`dual-try`](../dual-try/SKILL.md) |
| Wrong turn / doc swamp / bad premise | [`recover-wrong-turn`](../recover-wrong-turn/SKILL.md) |
| Catch the operator up in plain words | [`plain-status`](../plain-status/SKILL.md) |
| Orientation only (no work) | [`helm-help`](../helm-help/SKILL.md) |

## Autonomy

**Just do it** for reversible work inside the named stack and current slice.

**Always pause** (ask or state a default and wait if irreversible) for: production deploy, deleting real user data, billing, force-push to shared main, messaging real customers.

**Full-autonomy grant** ("don't stop", "I'm going to bed", "run until the checklist passes"): decide covered calls, act, keep a short decision trail in the reply. For calls only the operator can make, apply a **default**, say what you assumed, and say what they can override in plain words — never invent shorthand tokens they must memorize.

## Playbooks

Open a todo list whose first items are the matched playbook's steps (copy verbatim from the playbook file). Keep skipped steps as `skip: <reason>`.

Match the operator's ask to one playbook and open `playbooks/<file>.md`:

| Playbook | File | For |
|---|---|---|
| Greenfield MVP | [`playbooks/greenfield-mvp.md`](playbooks/greenfield-mvp.md) | New app / first usable version |
| Add capability | [`playbooks/add-capability.md`](playbooks/add-capability.md) | New user-visible behavior on an existing app |
| Fix outcome | [`playbooks/fix-outcome.md`](playbooks/fix-outcome.md) | Something fails an acceptance check or user flow |
| Change direction | [`playbooks/change-direction.md`](playbooks/change-direction.md) | Spec/product premise changed mid-flight |
| Spec only | [`playbooks/spec-only.md`](playbooks/spec-only.md) | Clarify and lock the living spec; do not build yet |
| Verify only | [`playbooks/verify-only.md`](playbooks/verify-only.md) | Acceptance pass / demo readiness |
| Recover | [`playbooks/recover.md`](playbooks/recover.md) | Doc swamp, wrong premise, unmaintainable context |
| Dual path | [`playbooks/dual-path.md`](playbooks/dual-path.md) | High uncertainty on UX approach; try two thin paths |

If nothing fits, design a **short** bespoke playbook (max 8 steps) that still ends in observable acceptance, and prefer reusing the sub-skills above over inventing new ceremony.

## Reply shape

Write for the operator:

1. **User-visible outcome** (what works now / what will work after this slice)
2. **Checklist** (observable acceptance for this slice)
3. **Waiting on you** (only real product gates; each decidable from the reply)
4. **Assumptions you made** (technical defaults; labeled)
5. Evidence labels in the same sentence: **measured** / **inferred** / **guess**

No long implementation tours. No asking them to read diffs. If they want depth, they will ask.

## Harness notes

This pack is harness-agnostic Agent Skills. Adapt mechanics to the host:

- **Subagents / second opinions:** if the host can spawn another agent or switch models, use that for `product-critique` and `dual-try`. If not, run a fresh critique pass in the same thread with an explicit blind rubric and do not reuse your own cheerleading.
- **Questions:** use the host's structured question tool when present; otherwise numbered A/B choices in chat.
- **Verification:** prefer actually running the app / tests / browser tools. If the environment cannot run, say so plainly and give the operator the exact click path.
- **Persistence:** keep `docs/helm-spec.md` in the project repo so new sessions can reload truth without the old chat.

More: [`references/harness.md`](references/harness.md), [`references/prompting.md`](references/prompting.md), [`references/terminology.md`](references/terminology.md).
