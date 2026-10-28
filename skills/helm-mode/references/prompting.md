# Prompting helm-mode

## Good first prompts

State **goal**, **stack constraints**, **how to know it works**, and **your role**.

```text
/helm-mode
Goal: personal URL shortener for me only.
Stack: Next.js + Supabase + Vercel. Do not change stack.
I do not read code. You implement and verify.
Only ask me product A/B questions (max 3), with your recommendation.
Done when: I can paste a URL, get a short link, open it, and see it redirect.
```

```text
/helm-mode change direction
We are dropping public signup. Spec should be invite-only admin.
Recover cheaply if needed. Then rebuild the auth slice only.
```

```text
/helm-mode verify only
Walk the acceptance checklist in docs/helm-spec.md.
Report pass/fail in plain language. Do not add features.
```

## Steers mid-flight (one liners)

- `apply decision-budget` — stop asking technical questions
- `apply one-source-of-truth` — merge into docs/helm-spec.md; delete extras
- `apply cheap-reversal` — revert this slice; rewrite spec; fresh plan
- `apply observable-acceptance` — rewrite ACs as clickable checks
- `plain-status` — tell me what changed and what needs my product call
- `dual-try this slice` — two short attempts; keep the better outcome
- `new task` — stop continuing the previous playbook

## Anti-patterns

- Listing five skill names in order (the router will drop or reorder; trust the playbook)
- Asking for a full architecture novel before any runnable slice
- "Make it production-ready" with no AC
- Continuing a polluted thread after a premise failure
