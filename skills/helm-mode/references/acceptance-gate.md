# Acceptance gate (bounded loop)

The single reference for **how a slice gets accepted**. Principle summary: [`../../principle-bounded-loop/SKILL.md`](../../principle-bounded-loop/SKILL.md).

Design intent: keep independent, stronger-model review — but make acceptance a **bounded, frozen, batched, tiered** gate instead of an open fix→review→verify loop.

## 1. The loop

```text
TIER + AC REVIEW (product-critique, once, before build) → FREEZE (slice card)
→ [shape-before-code]               (skip on simple)
→ build-outcome                     (self-check allowed; does not self-declare done)
→ COLLECT ROUND on one snapshot:
      verify-outcome  ∥  eng-critique   (eng-critique: first round only on standard)
→ TRIAGE (parent): dedupe → Must admission → Must / Deferred / Ignore
→ no Must and all frozen ACs + envelope PASS → PASS
→ else ONE fix batch (build-outcome, fix mode) → RE-VERIFY (narrow scope)  = 1 fix round
→ repeat until PASS | STOP: budget | STOP: no-progress
→ plain-status
```

Order is fixed. Do not run eng-critique before there is a build snapshot to verify, and do not edit code between the verify and eng-critique of the same collect round.

## 2. Risk tier

The parent decides the tier at slice start and writes one line: `Tier: <tier> — trigger: <which row>`.

| Tier | Triggers (any one) | Independent agents | Fix rounds |
|---|---|---|---|
| **high** | authn / authz / permissions; money / billing; deleting or migrating persisted user data (incl. schema migration); secrets, webhooks, or untrusted input crossing into a trusted zone; production / irreversible operations; a public API contract others depend on | per collect round ≤2 (verifier + eng-critic); per slice ≤5 | 2 |
| **standard** | not high, and any of: new or changed data shape / persistence; crosses ≥2 modules or layers; new dependency; new user flow with ≥3 ACs | per slice ≤2 | 2 |
| **simple** | none of the above: copy, style, one component / file-local logic; reversible; ≤2 ACs | 0 (parent thread only) | 1 |

Rules:

- `high` **must** name the trigger it hit. If you cannot name one, the tier is `standard`.
- `standard` is the normal case for new capabilities. Do not default to `high` "to be safe".
- **Upgrade** mid-slice is allowed when a trigger appears (e.g. build discovers a migration). Say why. Upgrading does **not** reset used fix rounds; it does add eng re-review for hard-risk code.
- **Downgrade** is allowed when the trigger turns out false; say so.
- A **role** from `/setup-helm` says *which model* does a job. It is **not** a mandate to spawn a separate agent. The tier decides spawning.
- Single-model hosts: same tiers, same budgets; "independent agent" becomes a blind pass in the same thread.

### What each tier runs

| Step | simple | standard | high |
|---|---|---|---|
| AC review (`product-critique`) | parent, inline, 1–2 lines | once, parent or 1 agent | once, independent |
| `shape-before-code` | skip | when crossing boundaries / new shape; parent thread OK | yes; independent shaper preferred |
| `eng-critique` | optional inline blind pass | once, first collect round | first collect round + re-review of fix diffs that touch hard-risk code |
| `verify-outcome` | parent | parent or 1 verifier agent | independent verifier |

## 3. Slice card

The one place for freeze / envelope / budget / deferred findings. Lives at the top of `docs/helm-now.md` (L1). If the project does not use `helm-now.md`, put it as the first item of the todo list. Required for `standard` and `high`; `simple` needs only the Tier line + ACs.

```markdown
## Slice card
Slice: <user outcome>
Tier: standard — trigger: new `links` table
Frozen AC (at build start): AC3, AC4
Envelope smokes (≤3): S1 home page loads; S2 existing short link still redirects
Fix rounds: 0/2
Deferred:
- [product] custom code length → next-slice candidate
- [eng/should] index on links.code
```

At slice end: promote product-relevant `Deferred` items **once** into L0a (P1 / Open product questions); drop the rest; clear the card. Do not sync it continuously with L0a.

## 4. Freeze

- **When:** at build start, after AC review.
- **What:** the slice ACs and the envelope smokes.
- **After freeze:** new product findings go to `Deferred`. Product-critique does not run again on this slice.
- **Exception:** a **hard-risk** finding (security / authz, data loss, secret leak, irreversible) may add a Must after freeze.
- **Unfreeze:** if verify shows an AC is unreachable or self-contradictory, that is **not a FAIL** — route to `change-direction` (rewrite L0a) or a human gate, then reopen the card. Fix rounds already used stay used.

## 5. Must admission (both critiques)

A finding is a **Must** only if one holds:

1. **Frozen-AC violation** with evidence: measured repro, or an exact input → wrong output.
2. **Hard-risk** class (security / authz, data loss or corruption, secret leak, irreversible damage) with a **concrete failure scenario**: who does what, and what goes wrong.

Everything else is **Should**: non-blocking, never opens a fix round on its own, logged under `Deferred`. The parent may fold a Should into the current fix batch only if it touches files already in that batch and is small. That never costs an extra round.

The parent applies admission during triage and **downgrades unevidenced Musts itself**; it does not send them back to the critic for argument.

## 6. Collect → triage → fix → re-verify

1. **Collect.** On one build snapshot, run `verify-outcome` and (when the tier says so) `eng-critique`, in parallel or back-to-back, with **no code edits in between**. eng-critique receives the verify evidence when available.
2. **Triage (parent).** Dedupe → apply Must admission → three buckets: **Must (this round)**, **Deferred**, **Ignore**.
3. **Fix batch.** All Musts go to **one** `build-outcome` call in fix mode. The builder gets the Must list (repro + expected), not the critics' essays.
4. **Re-verify scope.** FAILed ACs + ACs and envelope smokes whose area the fix diff touched (judge from the changed-file list). Not the whole P0.
5. **Eng re-review.** `standard`: none. `high`: only when the fix diff touches hard-risk code, and only that diff.

Counting: the first collect round is free. Each **fix batch + re-verify** is **one fix round**.

## 7. Exit states

| State | Condition | Action |
|---|---|---|
| **PASS** | all frozen ACs PASS, envelope smokes PASS, no open Must | `plain-status` → next slice |
| **STOP: budget** | fix rounds used up and a FAIL or Must remains | stop dispatching; `plain-status` with the options below |
| **STOP: no-progress** | after a fix round, the same FAIL persists, or something that PASSed now FAILs (oscillation) | stop **immediately**, even with budget left; same options; mark "needs root cause" so a later `fix-outcome` starts from the evidence |

Stop options (in **Waiting on you**, product language, with a recommendation):

- **A.** Accept what passes now; the failing behavior (one sentence on what users would see) moves to the next slice
- **B.** Authorize one more fix round
- **C.** Drop or rewrite this AC (patch L0a)
- **D.** The premise may be wrong → `change-direction`

**Full-autonomy grant:** take **A** by default, record it in the decision trail, mark the slice `partial`, continue with slices that do not depend on it. Never add rounds on your own.

**BLOCKED** (the environment cannot run the check) is not a FAIL and costs no budget. Give the operator one ≤2-minute click script, once; their confirmation is a human acceptance gate.

## 8. Regression envelope

- At freeze, name **≤3** adjacent smokes: flows the slice touches or that share its code.
- Full P0 regression runs only in: the `verify-only` playbook, before a production deploy, or when the operator asks.

## 9. Parent coordinator rules

- The parent `/helm-mode` thread is the **only** dispatcher: tier → freeze → dispatch → triage → issue fix batch → decide the exit state.
- Subagents **report**. They do not spawn subagents, and they do not fix code. The builder is the exception, and only executes the Must list it was given.
- Critics return findings, not patches.
- Per collect round: at most one verifier and one eng-critic. Never one agent per FAIL.
- `dual-try`: only on `standard` or `high`. Each attempt gets one verify. The two attempts share one eng-critique. Neither enters fix rounds. The winner then runs a normal collect round.

## 10. Anti-patterns

- Eng-critique without measured evidence producing a dozen Musts, fixed one by one
- Product-critique adding Musts after build started
- Re-running the full P0 smoke after every small fix
- Re-running eng-critique after every fix on a `standard` slice
- "One more round" past budget because it is "almost there"
- Every slice labeled `high`
