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
/helm-mode change direction
We are dropping public signup. Living contract should be invite-only admin.
Recover cheaply if needed. Then rebuild the auth slice only.
```

```text
/helm-mode verify only
Walk the acceptance checklist in docs/helm-spec.md.
Report pass/fail in plain language. Do not add features.
```

```text
/setup-helm
Prefer a different model for eng-critic than builder when available.
```

## Steers mid-flight (one liners)

- `apply decision-budget` — stop asking technical questions; use model gates
- `apply model-not-human-for-tech` — route this fork to eng-critique / dual-try
- `apply one-source-of-truth` / `apply thin-authority` — merge into docs/helm-spec.md; discard extra authorities
- `apply cheap-reversal` — revert this slice; rewrite L0a; fresh thread
- `apply observable-acceptance` — rewrite ACs as clickable checks
- `apply token-for-proof` — spend tokens on critique/verify, not more planning
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
