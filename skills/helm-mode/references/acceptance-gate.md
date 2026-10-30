# Acceptance gate (bounded loop)

The **single source** for how a slice gets accepted: tiers, agent caps, budgets, freeze, Must admission, rounds, exit states. Other files reference sections here (`acceptance-gate §n`) instead of restating numbers. Principle summary: [`../../principle-bounded-loop/SKILL.md`](../../principle-bounded-loop/SKILL.md).

Design intent: keep independent, stronger-model review — but make acceptance a **bounded, frozen, batched, tiered** gate instead of an open fix→review→verify loop.

## 1. The loop

```text
TIER (provisional) + AC REVIEW (product-critique, once, before build)
→ re-check tier once → FREEZE (slice card: tier, ACs, envelope, budget)
→ [shape-before-code]               (per §2)
→ build-outcome                     (self-check allowed; does not self-declare done)
→ COLLECT ROUND on one snapshot:  verify-outcome, then eng-critique (per §2)
→ TRIAGE (parent): dedupe → Must admission (§5) → Must / Deferred / Ignore
→ PASS?  else: checkpoint → ONE fix batch → RE-VERIFY (§6)   = 1 fix round
→ repeat until an exit state (§7)
→ plain-status
```

Order is fixed. **eng-critique runs only inside a collect round** (or the fix-diff re-review in §6) — never before a build snapshot exists, never as a generic "model gate" elsewhere. No code edits between the verify and the eng-critique of the same collect round. Default is back-to-back, verify first, so eng-critique gets the verify evidence; running them in parallel is allowed when the host benefits.

Other technical forks (shape choices, root cause, library picks) are decided by the parent with the `shaper` role or a short blind comparison in the parent thread — not by calling `eng-critique`.

## 2. Risk tier

The parent decides a **provisional** tier at slice start, re-checks it **once** after AC review (new failure-mode ACs may change it), then it freezes with the ACs. Write one line: `Tier: <tier> — trigger: <which trigger>`.

| Tier | Triggers (any one) |
|---|---|
| **high** | authn / authz / permissions; money / billing; **destructive or data-rewriting** change to existing user data (drop / rename column, backfill, bulk update, delete); secrets or webhook-signature handling; production / irreversible operations; a public API contract others depend on |
| **standard** | not high, and any of: new or changed data shape / persistence (**additive migrations — new table, new nullable column — are standard**); crosses ≥2 modules or layers; new dependency; new user flow |
| **simple** | none of the above triggers (copy, style, one component / file-local logic; reversible) |

Rules:

- `high` **must** name the trigger it hit. If you cannot name one, the tier is not high.
- `standard` is the normal case for new capabilities. Do not default to `high` "to be safe".
- An operator request such as `simple change` **requests** a tier; the high triggers still apply. If a trigger overrides the request, say so in one plain line.
- **Upgrade** mid-slice when a trigger appears (build discovers a destructive migration; an admitted **hard-risk** Must on a `standard` slice — trigger: "hard-risk finding"). Say why. Upgrading does **not** reset used fix rounds.
- **Downgrade** when the trigger turns out false; say so.
- A **role** from `/setup-helm` says *which model* does a job. It is **not** a mandate to spawn an agent. This table decides spawning.

### What each tier runs, and agent caps

| Step | simple | standard | high |
|---|---|---|---|
| AC review (`product-critique`) | parent, inline, 1–2 lines | once; parent or 1 agent | once; independent |
| `shape-before-code` | skip | when crossing boundaries / new shape; parent thread | yes; independent shaper preferred |
| `verify-outcome` | parent | parent or 1 verifier agent | independent verifier |
| `eng-critique` | optional inline blind pass | once, first collect round | first collect round + re-review of hard-risk fix diffs (§6) |
| **Independent agents per slice** | **0** | **≤2** | **≤4** |
| **Fix-round budget** | **1** | **2** | **2** |

Counting agents: count **distinct spawned reviewers / verifiers / shapers** per slice. The builder implementing the slice is not counted. Reusing the same verifier or eng-critic agent for a re-verify or a fix-diff re-review is **not** a new spawn. Single-model hosts: same tiers and budgets; "independent" becomes a blind pass in the same thread. **Single-model `high`:** the operator's ≤2-minute click script for each hard-risk AC is mandatory before PASS.

## 3. Slice card

The one place for tier / freeze / envelope / budget / deferred findings.

- `standard` / `high`: always at the top of `docs/helm-now.md` (create it if missing). The parent **pastes the card into every subagent brief**, because subagents cannot see the parent's todo list.
- `simple`: one Tier line + the ACs, in `helm-now.md` or the todo list.

```markdown
## Slice card
Slice: <user outcome>
Tier: standard — trigger: new `links` table (additive)
Frozen AC (at build start): AC3, AC4
Envelope smokes (≤3): S1 home page loads; S2 existing short link still redirects
Fix rounds: 0/2
Checkpoint: <commit before last fix batch>
Deferred:
- [product] custom code length → next-slice candidate
- [eng/should] index on links.code
Stopped behaviors: (filled on STOP; see §7 carry-over)
```

At slice end: promote product-relevant `Deferred` items and any `Stopped behaviors` **once** into L0a (P1 / Open product questions); drop the rest; clear the card. Do not sync it continuously with L0a.

## 4. Freeze

- **When:** at build start, after AC review and the tier re-check.
- **What:** the slice ACs and the envelope smokes.
- **After freeze:** new product findings go to `Deferred`. Product-critique does not run again on this slice (except the inline re-review of rewritten ACs on unfreeze).
- **Exception:** a **hard-risk** finding may add a Must after freeze, from any source (eng-critique, verifier, operator).
- **Unfreeze (AC-defect):** verify shows an AC is unreachable or self-contradictory. Not a FAIL.
  - Two ACs the operator wrote contradict each other, or fixing it changes scope / user-visible behavior → **human gate** (one A/B + recommendation). Under full autonomy: default "drop the contradictory AC; defer it", and say so.
  - The AC conflicts with the stack or reality → `change-direction`, rewriting only the affected AC lines in L0a.
  - Either way: **keep the slice card**, rewrite only the affected AC lines, re-run AC review **inline on those lines only**, keep `Fix rounds n/N` as is.

## 5. Must admission (all findings)

A finding is a **Must** only if one holds:

1. **Frozen-AC violation** with evidence: measured repro, or an exact input → wrong output.
2. **Hard-risk** class — security / authz (incl. untrusted input reaching trusted code), data loss or corruption, secret leak, irreversible damage — with a **concrete failure scenario**: who does what, and what goes wrong.

Everything else is **Should**: non-blocking, never opens a fix round on its own, logged under `Deferred`. The parent may fold a Should into the current fix batch only if it touches files already in that batch and is ≤10 lines. That never costs an extra round.

The parent applies admission during triage and **downgrades unevidenced Musts itself**; it does not send them back to the critic for argument. A hard-risk observation outside the frozen ACs is still reported as a finding (not silently deferred) so the parent can triage it.

## 6. Collect → triage → fix → re-verify

1. **Collect.** On one build snapshot: `verify-outcome`, then (per §2) `eng-critique` with the verify evidence. No edits in between.
2. **Triage (parent).** Dedupe → admission → **Must (this round)** / **Deferred** / **Ignore**.
3. **Checkpoint.** Git commit (or host equivalent) before the fix batch; record it in the card.
4. **Fix batch.** All Musts go to **one** `build-outcome` call in fix mode. The builder gets the Must list (repro + expected) and the slice card, not the critics' essays. A fix batch **counts as a round when issued**.
5. **Re-verify scope.** FAILed ACs + **all envelope smokes (always)** + ACs whose area the fix diff touched. Not the whole P0.
6. **Eng re-review.** `standard`: none (an admitted hard-risk Must upgrades the slice to `high` first). `high`: only when the fix diff touches **hard-risk code** — code in the modules named by the tier trigger or by a hard-risk Must — and only that diff, by the same eng-critic.
7. **Later rounds** work only on items still open.

Counting: the first collect round is free. Each issued **fix batch + its re-verify** is one fix round. If a re-verify is BLOCKED, the round still counts; it just waits for the click script.

## 7. Exit states

**Progress** after a fix round = at least one item from the fix batch went FAIL→PASS (or Must closed), and nothing went PASS→FAIL.

| State | Condition | Action |
|---|---|---|
| **PASS** | all frozen ACs PASS, envelope smokes PASS, no open Must | `plain-status` → next slice |
| **STOP: budget** | fix rounds used up and a FAIL or Must remains | stop dispatching; stop options |
| **STOP: no-progress** | after a fix round: (a) no item of the batch went FAIL→PASS, or (b) anything went PASS→FAIL (oscillation), or (c) an item still FAILs with the **same observed vs expected** for the second consecutive fix round. Some fixed + others still failing with new evidence **is progress**: continue on the remaining items within budget | stop **immediately**, even with budget left; on (b) **revert to the checkpoint** so everything that passed before passes again; stop options; record "needs root cause" |
| **PENDING-HUMAN** | every remaining item is BLOCKED or an AC-defect waiting on the operator | one click script / one A/B; no budget spent while waiting |
| **partial** | the result of option A or A′ (below) | record what was deferred; continue with independent slices |

### Stop options

In **Waiting on you**, product language. Each option says what you get and what it costs. Recommendation is fixed by stop type: budget → **A**; no-progress → **D**; any open **hard-risk** Must → **A′**.

- **A.** Accept the last state where nothing that worked before is broken; the failing behavior (one sentence on what users would see) moves to the next slice
- **A′.** (hard-risk open) Switch off or revert the risky part (feature off / revert to checkpoint); everything else stays; the risky part waits for you
- **B.** Allow one more fix round ("last try fixed 2 of 3")
- **C.** Drop or rewrite this requirement (patch L0a)
- **D.** Rethink the approach — the premise may be wrong (`change-direction`)

**Full-autonomy grant:** take **A** by default — or **A′** if any open Must is hard-risk; never leave a hard-risk hole live, and never build later slices on top of it. Record the choice in the decision trail, mark the slice `partial` (or `blocked-on-human` for A′), continue only with slices that do not depend on it. Never add rounds on your own.

### Carry-over rule (no cross-slice reset)

A behavior that exited with STOP is listed under `Stopped behaviors` and promoted to L0a Open product questions as "needs root cause". It is **not** re-attempted in this session under a full-autonomy grant — not as a new slice, a new `fix-outcome`, or a reslice after `change-direction`. Only an operator choice (B, or a new explicit fix request) re-opens it, and that re-attempt gets a fresh budget **once**. A second STOP on the same behavior always recommends **D**.

**BLOCKED** (the environment cannot run the check) is not a FAIL. Give the operator one ≤2-minute click script, once; their confirmation is a human acceptance gate.

## 8. Regression envelope

- At freeze, name **≤3** adjacent smokes: flows the slice touches or that share its code. They run in every collect round and every re-verify.
- Full P0 regression runs only in: the `verify-only` playbook, before a production deploy, or when the operator asks.

## 9. Parent coordinator rules

- The parent `/helm-mode` thread is the **only** dispatcher: tier → freeze → dispatch → triage → issue fix batch → decide the exit state.
- Subagents **report**. They do not spawn subagents and do not fix code. The builder is the exception, and only executes the Must list it was given.
- Critics return findings, not patches.
- Never one agent per FAIL, and never one playbook run per FAIL: multiple failing ACs go into one slice / one card / one budget.
- `dual-try`: only on `standard` / `high`. Each attempt gets one verify and no fix rounds; the two attempts share one eng-critique. The bakeoff may use up to 4 agents in total; that replaces the slice cap for this slice. The keeper's next collect round is verify-only if the shared eng-critique reviewed the keeper's code.

## 10. Anti-patterns

- Eng-critique without measured evidence producing a dozen Musts, fixed one by one
- Calling eng-critique as a generic model gate outside a collect round
- Product-critique adding Musts after build started
- Re-running the full P0 smoke after every small fix
- "One more round" past budget because it is "almost there"
- Re-slicing a stopped behavior to get a fresh budget
- Accepting a slice with a known hard-risk hole live
- Every slice labeled `high`; every migration labeled `high`
