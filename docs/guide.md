# helm-stack guide

## Who this is for

You want to build software with coding agents while controlling **requirements, stack, direction, and acceptance** — not while reading diffs. You tried heavy planning packs and got stuck in document/context mud. You want **one command**, precise vocabulary, and verification that speaks plain language.

## Quick start

1. Install the skills into your harness (`npx skills add …` or copy `skills/`).
2. In a project folder, run:

```text
/helm-mode
Goal: …
Stack: …
I do not read code. Decide plumbing yourself.
Done when: …
```

3. Expect a living spec at `docs/helm-spec.md` and slice-by-slice verify reports.

## Design heritage

From **pstack / poteto-mode** we kept:

- One router skill + playbooks
- Sub-skills loaded by the router (you need not memorize names)
- Named principles as steering vocabulary
- Autonomy that refuses to block the human on reversible work

We changed the optimization target:

| pstack emphasis | helm-stack emphasis |
|---|---|
| Engineering depth, adversarial code quality | Product gates + observable acceptance |
| Many specialized engineering skills | Few commander skills |
| Parallel engineering fleets by default | Optional dual-try / critique when uncertainty is high |
| Assume you can judge diffs | Assume you judge click paths |

## When to spend more tokens

Yes — more tokens can buy better usability **if** they buy proof:

- `dual-try` on a UX fork
- `product-critique` with a second model
- extra `verify-outcome` loops

Do not buy more planning chapters.

## Recovery mantra

Wrong early → **cheap-reversal** → new living spec → fresh thread → next slice.
