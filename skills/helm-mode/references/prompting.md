# Prompting helm-mode

## Good first prompts

State **goal**, **stack constraints**, **how to know it works**, and **your role**.

```text
/helm-mode
Goal: personal URL shortener for me only.
Stack: Next.js + Supabase + Vercel. Do not change stack.
I do not read code. You implement; use stronger models for engineering review.
Only ask me product/UX A/B questions (max 3), with your recommendation.
Done when: I can paste a URL, get a short link, open it, and see it redirect.
```

```text
/helm-mode
L0a is our existing docs/PRD.md (features + 验收). Do not create docs/helm-spec.md.
Pin docs/helm.contract if missing. Continue from current slice.
```

```text
/helm-mode change direction
We are dropping public signup. Living contract should be invite-only admin.
Recover cheaply if needed. Then rebuild the auth slice only.
```

```text
/helm-mode verify only
Walk the acceptance checklist in the living contract (PRD or helm-spec).
Report pass/fail in plain language. Do not add features.
```

```text
/setup-helm
Prefer a different model for eng-critic than builder when available.
```

## Steers mid-flight (one liners)

- `apply decision-budget` — stop asking technical questions; use model gates
- `apply model-not-human-for-tech` — route this fork to a stronger model in the parent or an eng dual-try
- `apply one-source-of-truth` / `apply thin-authority` — one L0a only; pin with docs/helm.contract; never PRD+helm-spec duplicates
- `apply cheap-reversal` — revert this slice; rewrite L0a; fresh thread
- `apply observable-acceptance` — rewrite ACs as clickable checks
- `apply token-for-proof` — spend tokens on one strong round of verify/critique, not more planning or more rounds
- `apply bounded-loop` — tier the slice (say the trigger), freeze ACs + envelope, collect verify + eng findings before fixing, Musts need AC evidence or a hard-risk scenario, stay inside the fix-round budget, stop on no progress (`acceptance-gate.md`)
- `simple change` — request the `simple` tier (parent thread only); high triggers still apply, and the agent says so if one overrides the request
- `plain-status` — Waiting on you vs Handled by models
- `dual-try this slice` — two short attempts; say ux-fork or eng-fork
- `new task` — stop continuing the previous playbook

## Anti-patterns

- Listing five skill names in order (trust the playbook)
- Asking for a full architecture novel before any runnable slice
- Opening parallel `architecture.md` / `tasks-v3.md` as second truth
- "Make it production-ready" with no AC
- Asking the operator to judge diffs or pick libraries
- Continuing a polluted thread after a premise failure
- "Keep fixing until everything passes" with no round budget (use a full-autonomy grant; the gate still stops and defers)
