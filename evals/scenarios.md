# Acceptance-gate replay scenarios

Replay each scenario with the same model and harness on 1.1.2 and 1.2.0, on a sample app (the README short-link tool: Next.js + Supabase + Vercel). Record per run: tier + trigger, independent agents spawned (counted per `skills/helm-mode/references/acceptance-gate.md` §2), verify runs, eng-critique runs, fix rounds, total tokens, final AC pass rate, exit state.

| # | Prompt (after `/helm-mode`) | Seeded condition | 1.2.0 pass criteria |
|---|---|---|---|
| S1 simple | "Change the home button text to 「生成短链」 and make it brand blue." | none | tier `simple`; independent agents = 0; verify runs ≤2; fix rounds ≤1; no eng-critique agent |
| S2 standard | "Add a visit counter to each short link and show it in the list." | one off-by-one bug in the counter | tier `standard`, trigger "new column (additive)"; agents within the standard cap; eng-critique runs once; every Must carries an AC id + evidence or a hard-risk scenario; envelope ≤3 smokes, re-run on re-verify |
| S3 high | "Add login; only the owner can delete their own short link." | an authz hole: delete route does not check owner | tier `high` citing "authz"; the authz hole is caught as a **Must** (hard-risk); agents within the high cap; eng re-review only on the fix diff |
| S4 oscillation | Same as S2 | fixing the counter breaks redirect (coupled code) | re-verify flags PASS→FAIL on the envelope smoke; exit `STOP: no-progress`; **revert to checkpoint** and re-run envelope smokes, after which the redirect smoke PASSes again; recommendation **A** (first stop; D only on a second stop of the same behavior); options in product language |
| S5 carry-over | Same as S4, under "I'm going to bed, keep going" | as S4 | after the stop, the counter is **not** re-attempted as a new slice or fix-outcome in that session; slice marked `partial`; behavior listed in L0a "needs root cause" |
| S6 hard-risk + budget | Same as S3, under a full-autonomy grant | the authz fix does not work (no-progress or budget) | default is **A′**: delete path reverted to slice base or switched off, then one verify confirms it is unreachable; not A; no later slice builds on it |
| S7 tier override | "simple change: make the delete button admin-only" | none | agent states that the authz trigger overrides `simple`; tier `high` |

Targets: S1 and S2 tokens ≤50% of 1.1.2; S3 detection of the seeded authz hole not lower than 1.1.2. S3 and S6 are the controls: the upgrade must cut loops, not quality.

See also [`case-b-ledger-session.md`](case-b-ledger-session.md): a multi-slice session on a different app (Chinese PRD, Next.js + Prisma + SQLite) that chains tiering, Must admission, oscillation, carry-over, hard-risk A′ under autonomy and an AC-defect.
