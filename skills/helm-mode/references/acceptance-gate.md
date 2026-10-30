# Acceptance gate (bounded loop)

The **single source** for how a slice gets accepted: tiers, agent caps, budgets, freeze, Must admission, rounds, exit states. Other files reference sections here (`acceptance-gate §n`) instead of restating numbers. Principle summary: [`../../principle-bounded-loop/SKILL.md`](../../principle-bounded-loop/SKILL.md).

Design intent: keep independent, stronger-model review — but make acceptance a **bounded, frozen, batched, tiered** gate instead of an open fix→review→verify loop.

## Slice checklist (parent) — the rest of this file is reference

1. Tier the slice by the §2 triggers; write `Tier: <tier> — trigger: <trigger>`.
2. Record **Slice base** (current commit; `git init` + commit if the project has none).
3. AC review (§2 table) → contradictory operator ACs go to the human gate (§4) → re-check tier once.
4. Freeze ACs + envelope smokes in the slice card (§3); paste the card into every subagent brief.
5. Build. Then collect round: verify first, then eng-critique if the tier runs it (§6).
6. Triage with Must admission (§5). No Must and everything passes → PASS.
7. Checkpoint → one fix batch → re-verify (§6). This is one fix round.
8. Decide the exit state (§7): PASS, or stop with options. Never start a round past the budget.
9. Slice end: write the ledger line, promote Deferred / Stopped behaviors to L0a, clear the card (§3).

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

Order is fixed:

- **eng-critique runs only inside a collect round** (or the fix-diff re-review in §6) — never before a build snapshot exists, never as a generic "model gate" elsewhere.
- Default order: verify first, then eng-critique with the verify evidence. Parallel is allowed when the host benefits.
- No code edits between the verify and the eng-critique of the same collect round.

Other technical forks (shape choices, root cause, library picks) are decided by the parent with the `shaper` role or a short blind comparison in the parent thread — not by calling `eng-critique`.

## 2. Risk tier

The parent decides a **provisional** tier at slice start, re-checks it **once** after AC review (new failure-mode ACs may change it), then it freezes with the ACs. Write one line: `Tier: <tier> — trigger: <which trigger>`.

| Tier | Triggers (any one) |
|---|---|
| **high** | authn / authz / permissions; money / billing — code that **charges, moves or settles real money** (payments, invoices, balances others rely on; an app that only records or displays amounts is not high by this trigger); **destructive or data-rewriting** change to existing user data (drop / rename column, backfill that computes values from existing data, bulk update, delete); secrets or webhook-signature handling; production / irreversible operations; a public API contract others depend on |
| **standard** | not high, and any of: new or changed data shape / persistence (**additive migrations — new table, new column that is nullable or has a constant default — are standard**); crosses ≥2 layers (UI / API / DB — count by what the user flow touches, not by file; style and theme files do not count); new dependency; new user flow |
| **simple** | none of the above triggers (copy, style, one component / file-local logic; reversible) |

Rules:

- `high` **must** name the trigger it hit. If you cannot name one, the tier is not high.
- `standard` is the normal case for new capabilities. Do not default to `high` "to be safe".
- An operator request such as `simple change` **requests** a tier; every trigger in the table (high and standard) still applies. If a trigger overrides the request, say so in one plain line.
- **Upgrade** mid-slice when a trigger appears (build discovers a destructive migration; an admitted **hard-risk** Must on a `simple` or `standard` slice — trigger: "hard-risk finding" → `high`). Say why.
  - Does **not**: reset used fix rounds, re-run AC review, re-run shaping.
  - Adds: an independent verifier and the fix-diff re-review.
- **Downgrade** when the trigger turns out false; say so.
- A **role** from `/setup-helm` says *which model* does a job. It is **not** a mandate to spawn an agent. This table decides spawning.

### What each tier runs, and agent caps

| Step | simple | standard | high |
|---|---|---|---|
| AC review (`product-critique`) | parent, inline, 1–2 lines | once; parent or 1 agent | once; independent |
| `shape-before-code` | skip | when crossing boundaries / new shape; parent thread | yes; independent shaper preferred |
| `verify-outcome` | parent | parent or 1 verifier agent | independent verifier |
| `eng-critique` | optional inline blind pass | once, first collect round | first collect round + re-review of hard-risk fix diffs (§6) |
| **Independent agents per slice** | **0** | **≤2** (prefer verifier + eng-critic; AC review in the parent) | **≤4** |
| **Fix-round budget** | **1** | **2** | **2** |

Counting agents:

- Count **by role, not by instance**: the distinct product-critic / shaper / verifier / eng-critic roles spawned per slice. The builder is not counted.
- A fresh agent in a role already counted (a verifier for a re-verify, the eng-critic for a fix-diff re-review) does **not** count again — so one-shot-subagent hosts fit the same caps.
- Single-model hosts: same tiers and budgets; "independent" becomes a blind pass in the same thread. **Single-model `high`:** the operator's ≤2-minute click script for each hard-risk AC is mandatory before PASS.
- Only the **parent** spawns. A verifier or critic agent never spawns anything.

## 3. Slice card

The one place for tier / freeze / envelope / budget / deferred findings.

- `standard` / `high`: always at the top of `docs/helm-now.md` (create it if missing). The parent **pastes the card into every subagent brief**, because subagents cannot see the parent's todo list.
- `simple`: one Tier line + the ACs + 1 envelope smoke (the nearest existing core flow), in `helm-now.md` or the todo list.

```markdown
## Slice card
Slice: <user outcome>
Tier: standard — trigger: new `links` table (additive)
Frozen AC (at build start): AC3, AC4
Envelope smokes (≤3): S1 home page loads; S2 existing short link still redirects
Fix rounds: 0/2
Slice base: <commit before the slice's first build>
Checkpoint: <commit before last fix batch>
Deferred:
- [product] custom code length → next-slice candidate
- [eng/should] index on links.code
Stopped behaviors: (filled on STOP or A′; see §7)
Decision trail: (one line per default applied under full autonomy)
```

At slice end:

1. Append one **ledger line** to the `## Ledger` section at the bottom of `docs/helm-now.md` (kept across slices; delete only on a premise change): `<slice> | tier+trigger | agents by role | verify/eng/product runs | fix rounds n/N | exit state`.
2. Promote product-relevant `Deferred` items **once** into L0a (P1 / Open product questions), and `Stopped behaviors` into L0a `## Known gaps` (create that heading if missing).
3. Drop the rest; clear the card. Do not sync it continuously with L0a.

## 4. Freeze

- **When:** at build start, after AC review and the tier re-check.
- **What:** the slice ACs and the envelope smokes.
- **After freeze:** new product findings go to `Deferred`. Product-critique does not run again on this slice (except the inline re-review of rewritten ACs on unfreeze).
- **Exception:** a **hard-risk** finding may add a Must after freeze, from any source (eng-critique, verifier, operator).
- **Unfreeze (AC-defect):** verify shows an AC is unreachable or self-contradictory. Not a FAIL.
  - Two ACs the operator wrote contradict each other, or fixing it changes scope / user-visible behavior → **human gate** (one A/B + recommendation). Under full autonomy: default **keep the AC that protects against bad data or security (else the one earlier in L0a); drop the other and defer it**; name both in one plain line. After the default is applied, the slice continues normally (not `PENDING-HUMAN`); the dropped AC is listed in the next status as an operator choice.
  - The same applies when AC review finds the contradiction **before** freeze: AC-defect → human gate (or the autonomy default), then freeze.
  - The AC conflicts with the stack or reality → `change-direction`, rewriting only the affected AC lines in L0a.
  - Either way: **keep the slice card**, rewrite only the affected AC lines, re-run AC review **inline on those lines only**, keep `Fix rounds n/N` as is.
  - At most **one** unfreeze per slice. A second AC-defect on the same slice → `STOP` with options.

## 5. Must admission (all findings)

A finding is a **Must** only if one holds:

1. **Frozen-AC violation** with evidence: measured repro, or an exact input → wrong output.
2. **Hard-risk** class — security / authz (incl. untrusted input reaching trusted code), data loss or corruption, secret leak, irreversible damage — with a **concrete failure scenario**: who does what, and what goes wrong.

Everything else is **Should**: non-blocking, never opens a fix round on its own, logged under `Deferred`. The parent may fold a Should into the current fix batch only if it touches files already in that batch and is ≤10 lines. That never costs an extra round.

The parent applies admission during triage and **downgrades unevidenced Musts itself**; it does not send them back to the critic for argument. A hard-risk observation outside the frozen ACs is still reported as a finding (not silently deferred) so the parent can triage it.

## 6. Collect → triage → fix → re-verify

1. **Collect.** On one build snapshot: `verify-outcome`, then (per §2) `eng-critique` with the verify evidence. No edits in between.
2. **Triage (parent).** Dedupe → admission → **Must (this round)** / **Deferred** / **Ignore**.
3. **Checkpoint.** Git commit (or host equivalent) before the fix batch; record it in the card. (The **slice base** commit is recorded before the first build.)
4. **Fix batch.** All Musts go to **one** `build-outcome` call in fix mode. The builder gets the Must list (repro + expected) and the slice card, not the critics' essays. A fix batch **counts as a round when issued**.
5. **Re-verify scope.** FAILed ACs + **the repro of every Must in the batch, measured** (a hard-risk Must is closed by its repro failing to reproduce, not by review) + **all envelope smokes (always)** + ACs that exercise any file in the builder's changed-file list. Not the whole P0.
6. **Eng re-review.** `standard`: none (an admitted hard-risk Must upgrades the slice to `high` first). `high`: only when the fix batch changed files that implement the trigger or a hard-risk Must (e.g. the delete route, the auth check) — and only that diff, by the same eng-critic role.
7. **Later rounds** work only on items still open.

Counting: the first collect round is free. Each issued **fix batch + its re-verify** is one fix round. If a re-verify is BLOCKED, the round still counts; it just waits for the click script, and BLOCKED items are excluded from the progress check.

## 7. Exit states

**Progress** after a fix round = at least one item from the fix batch went FAIL→PASS (or Must closed), and nothing went PASS→FAIL. BLOCKED items are excluded; if every batch item is BLOCKED, the state is PENDING-HUMAN.

When several states hold: **PENDING-HUMAN > STOP: no-progress > STOP: budget**.

| State | Condition | Action |
|---|---|---|
| **PASS** | all frozen ACs PASS, envelope smokes PASS, no open Must | `plain-status` → next slice |
| **STOP: budget** | fix rounds used up and a FAIL or Must remains | stop dispatching; stop options |
| **STOP: no-progress** | see the no-progress rule below | see below |
| **PENDING-HUMAN** | every remaining item is BLOCKED, or an AC-defect waiting on the operator with no autonomy default applied | one click script / one A/B; no budget spent while waiting; under a full-autonomy grant, continue with independent slices meanwhile |
| **partial** | the result of option A | record what was deferred; continue with independent slices |
| **blocked-on-human** | the result of option A′ | risky part off; nothing builds on it; continue with independent slices |

**No-progress rule.** After a fix round, it is no-progress if: (a) nothing in the batch went FAIL→PASS; or (b) anything went PASS→FAIL (oscillation); or (c) an item has the same observed-vs-expected for the second consecutive fix round. Some items fixed while others still fail with new evidence **is progress** — continue on the remaining items within budget.

Actions on no-progress: stop now, even with budget left. On (b): revert to the checkpoint, then re-run the envelope smokes once (not a fix round). Record "needs root cause". Then stop options.

### Stop options

In **Waiting on you**, product language. Each option says what you get and what it costs. Recommendation is fixed: any open **hard-risk** Must → **A′**; otherwise the first STOP on a behavior (budget or no-progress) → **A**; a second STOP on the same behavior → **D**. A first no-progress is usually a technical root-cause problem, not a wrong premise — the operator should not be asked to judge that.

- **A.** Accept the last state where nothing that worked before is broken; the failing behavior (one sentence on what users would see) is recorded under `Stopped behaviors` / L0a Known gaps — not auto-scheduled (see carry-over). **Its unfinished entry point is hidden or disabled** (or the slice reverted to the slice base) so users cannot reach the failing path; check that in the same envelope re-run
- **A′.** (hard-risk open) Revert the risky part to the **slice base**, or put it behind an off switch; then run **one** verify of the envelope smokes + a "risky path unreachable" check (not a fix round). If that verify fails, revert the whole slice to the slice base. Everything else stays; the risky part waits for you. Record the switched-off feature, and how to switch it back on, under `Stopped behaviors` / L0a Known gaps
- **B.** Allow one more fix round — adds exactly **1** round to this slice ("last try fixed 2 of 3")
- **C.** Drop or rewrite this requirement (patch L0a)
- **D.** Rethink the approach — the premise may be wrong (`change-direction`)

**Full-autonomy grant:** take **A** by default — or **A′** if any open Must is hard-risk; never leave a hard-risk hole live, and never build later slices on top of it. Record the choice as one line under `Decision trail` in the slice card, mark the slice `partial` (or `blocked-on-human` for A′), continue only with slices that do not depend on it. Never add rounds on your own.

### Carry-over rule (no cross-slice reset)

A behavior that exited with STOP (or was switched off by A′) is listed under `Stopped behaviors` and promoted to L0a Known gaps. It is **not** re-attempted in this session under a full-autonomy grant — not as a new slice, a new `fix-outcome`, or a reslice after `change-direction`. Only an operator choice re-opens it: B adds one round; a new explicit fix request starts one `fix-outcome` with that tier's normal budget, **once**. A second STOP on the same behavior always recommends **D**.

Under a full-autonomy grant, at most **one** `verify-only` → `fix-outcome` cycle per session; a behavior that regresses again after it is treated as stopped.

**BLOCKED** (the environment cannot run the check) is not a FAIL. Give the operator one ≤2-minute click script, once; their confirmation is a human acceptance gate.

## 8. Regression envelope

- At freeze, name **≤3** adjacent smokes (`simple`: 1): flows the slice touches or that share its code — include any flow that shares a parser, model or helper the slice changes. They run in every collect round and every re-verify.
- **Destructive checks** (delete / clear / overwrite) run only on a disposable copy or seeded database, never on the operator's real data. If no safe copy can be made, mark BLOCKED and give a click script.
- Full P0 regression runs only in: the `verify-only` playbook, before a production deploy, or when the operator asks.

## 9. Parent coordinator rules

- The parent `/helm-mode` thread is the **only** dispatcher: tier → freeze → dispatch → triage → issue fix batch → decide the exit state.
- Subagents **report**. They do not spawn subagents and do not fix code. The builder is the exception, and only executes the Must list it was given.
- Critics return findings, not patches.
- Never one agent per FAIL, and never one playbook run per FAIL: multiple failing ACs go into one slice / one card / one budget.
- `dual-try`: only on `standard` / `high`. Each attempt gets one verify and no fix rounds; the two attempts share one eng-critique. The bakeoff may use up to 4 agents, plus the tier's pre-build agents (AC review, shaper); that replaces the slice cap for this slice. Refresh the slice card (keep `Fix rounds`); never delete it mid-slice. The keeper's next collect round is verify-only if the shared eng-critique reviewed the keeper's code.

## 10. Anti-patterns

- Eng-critique without measured evidence producing a dozen Musts, fixed one by one
- Calling eng-critique as a generic model gate outside a collect round
- Product-critique adding Musts after build started
- Re-running the full P0 smoke after every small fix
- "One more round" past budget because it is "almost there"
- Re-slicing a stopped behavior to get a fresh budget
- Accepting a slice with a known hard-risk hole live
- Every slice labeled `high`; every migration labeled `high`
