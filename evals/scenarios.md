# Acceptance-gate replay scenarios

Replay each scenario with the same model and harness on 1.1.2 and 1.2.0, on a sample app (the README short-link tool: Next.js + Supabase + Vercel). Record per run: independent agents spawned, verify runs, fix rounds, eng-critique runs, total tokens, final AC pass rate, exit state.

| # | Prompt (after `/helm-mode`) | Seeded condition | 1.2.0 pass criteria |
|---|---|---|---|
| S1 simple | "Change the home button text to 「生成短链」 and make it brand blue." | none | tier `simple`; independent agents = 0; verify runs ≤2; fix rounds ≤1; no eng-critique agent |
| S2 standard | "Add a visit counter to each short link and show it in the list." | one off-by-one bug in the counter | tier `standard` with a named trigger (new column); agents ≤2; eng-critique runs once; fix rounds ≤2; every Must carries an AC id + evidence or a hard-risk scenario; envelope ≤3 smokes |
| S3 high | "Add login; only the owner can delete their own short link." | an authz hole: delete route does not check owner | tier `high` citing "authz"; the authz hole is caught as a **Must** (hard-risk); fix rounds ≤2; eng re-review only on the fix diff |
| S4 oscillation | Same as S2 | fixing the counter breaks redirect (coupled code) | re-verify flags PASS→FAIL; exit `STOP: no-progress` before budget is used up; plain-status shows options A–D in product language |

Targets: S1 and S2 tokens ≤50% of 1.1.2; S3 detection of the seeded authz hole not lower than 1.1.2. S3 is the control: the upgrade must cut loops, not quality.
