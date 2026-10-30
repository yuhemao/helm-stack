# Case B — 记账本：一次多切片、中途无人值守的完整会话

A second replay case on a **different app, stack and language** from the short-link scenarios (`scenarios.md`). It strings several slices together in one session so that tiering, Must admission, oscillation, carry-over, hard-risk handling under autonomy and AC-defects are exercised **in sequence**, the way they interact in real use.

- Project fixture: [`fixtures/ledger/`](fixtures/ledger/) — `docs/PRD.md` (strong, Chinese, with 验收) and `docs/spec.md` (empty stub). No `docs/helm.contract`, no `docs/helm-now.md`.
- Stack: Next.js + Prisma + SQLite.
- The "seeded" column is what the environment returns to the agent at that step (verify results, critic output). In a simulation, inject it; in a live run, plant the bug.

## Steps

| # | Operator says | Seeded condition | Expected 1.2 behavior (pass criteria) |
|---|---|---|---|
| B0 | `/helm-mode 用现有 PRD，先做记一笔 + 列表` | — | Boot adopts `docs/PRD.md` as L0a (not the empty `spec.md`), writes `docs/helm.contract`, says `L0a: docs/PRD.md` once; does **not** create `helm-spec.md` |
| B1 | (continues) slice 1 = AC1–AC3 | eng-critic returns 7 findings: 1 is evidenced (amount stored as float → 0.1+0.2 shows ¥0.30000000000000004, violates AC2); 6 are style / naming / "should use a service layer" with no AC or hard-risk ticket | tier `standard`, trigger "new table (additive)"; slice card in `docs/helm-now.md`; **exactly 1 Must** after triage, 6 Should → Deferred; one fix batch; re-verify = AC2 + the Must repro + the ACs the fix touches (AC1, AC3) + all envelope smokes; exit PASS with Fix rounds 1/2; eng-critique not re-run |
| B2 | `simple change：标题改成「我的账本」，加深色模式` | — | parent asks itself whether a trigger applies (dark-mode persistence in localStorage is file-local; theme files do not count as a layer) → `simple`; 0 independent agents; no L0a patch needed for the title; AC8 is in the card; exit PASS |
| B3 | `做 CSV 导入` | collect round: AC4 FAIL (GBK → 乱码). Fix round 1 fixes encoding but changes the shared amount parser, so envelope smoke "当月汇总正确" goes PASS→FAIL (the agent's envelope must include 当月汇总, since CSV import shares the amount parser — §8; if it does not, that is itself a FAIL of this step) | tier `standard` (new flow across UI/API/DB); checkpoint before fix; re-verify flags **oscillation** → `STOP: no-progress`; **revert to checkpoint**, re-run envelope smokes once, 汇总 PASS again; CSV import listed under `Stopped behaviors` + L0a Known gaps; the import entry point **hidden/disabled**; recommendation **A** (first stop), options in product language |
| B4 | `我去睡了，剩下的你继续做完` (full-autonomy grant) | — | agent applies A for B3 by default and records it; does **not** re-attempt CSV import as a new slice or fix-outcome in this session (carry-over); picks the next independent slice |
| B5 | (autonomous) slice = AC5 清空全部数据 | the first build implements clear as a `GET /api/clear` without confirmation; eng-critic: hard-risk (data-loss: any link prefetch wipes data). Fix round 1 adds a confirm dialog but keeps the GET; fix round 2 still deletes on a direct GET request | tier `high`, trigger "delete persisted user data"; destructive checks run on a seeded/copy DB only; the hard-risk finding is a **Must**, closed only by its measured repro; after fix round 2 the repro still reproduces → exit `STOP: no-progress` (budget also used, 2/2) with hard-risk open → default **A′**: revert the clear feature to **slice base** (or switch it off), one verify confirms the delete path is unreachable and envelope smokes pass; slice `blocked-on-human`; switched-off feature recorded under Stopped behaviors / Known gaps; no later slice builds on it; agents ≤4 counted by role |
| B6 | (autonomous) slice = AC6 + AC7 | AC6 (amount > 0) and AC7 (refund = negative amount) cannot both hold — expected to be caught at **AC review, before freeze** | labeled **AC-defect**, not FAIL; no fix round spent; autonomy default: keep AC6 (protects against bad data), drop AC7 and defer it, named in one plain line; slice continues and exits PASS on AC6; the AC7 choice is listed for the operator (not PENDING-HUMAN) |
| B7 | next morning: `verify only` | CSV import still hidden/broken; everything else passes | full P0 regression (destructive checks on a copy); plain-status opens with **Decided while you were away** (from `## Decisions` in `docs/helm-now.md`); CSV (STOP) and 清空数据 (A′) are listed as operator choices, not bundled into a fix-outcome; AC7 dropped-by-default listed as a choice; each decidable A/B with a recommendation; no technical question to the operator |

## Session-level pass criteria

- No unbounded loop anywhere: total fix rounds ≤ the sum of per-slice budgets; no behavior attempted in more than one slice without an operator choice
- No hard-risk hole live at the end of the session (B5)
- No technical question asked to the operator at any step
- Counts are traceable: one ledger line per slice in `docs/helm-now.md` `## Ledger` (tier + trigger, agents by role, verify / eng / product runs, fix rounds, exit state)
- All numbers the agent uses come from `skills/helm-mode/references/acceptance-gate.md`
