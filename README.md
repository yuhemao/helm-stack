# helm-stack

A portable **Agent Skills** pack for people who steer products with AI coding agents — without reading code.

Inspired by [pstack](https://github.com/cursor/plugins/tree/main/pstack)'s `/poteto-mode` design: **one main command**, the agent loads the right sub-skills. Tuned for a **Commander** workflow (requirements, scope, direction, acceptance) rather than senior-engineer rigor theater.

Works in any harness that supports the [Agent Skills](https://agentskills.io) standard: Cursor, Claude Code, Codex, and others.

## Install

```bash
npx skills add yuhemao/helm-stack
```

Or copy the `skills/` folder into your agent skills directory.

Then, in chat:

```text
/helm-mode 我想做一个个人短链工具。技术栈 Next.js + Supabase + Vercel。我看不懂代码，你负责实现和验收跑通；只在产品取舍上问我。
```

Stuck on which skill? `/helm-help`

## Remember one command

| You type | What happens |
|---|---|
| **`/helm-mode`** | Default entry. Matches a playbook, loads sub-skills as steps need them. |
| `/helm-help` | Orientation only. Hands you a prompt; does not start the work. |

You usually do **not** need to memorize the rest. `helm-mode` routes to them.

## What this optimizes for

- **One living source of truth** (`docs/helm-spec.md`), not a document pyramid
- **Decision budget**: technical calls default to the agent; you only get product A/B questions
- **Observable acceptance**: done means you can click through a checklist, not "code looks fine"
- **Cheap reversal**: when early assumptions were wrong, revert the slice and rewrite the spec — do not patch ten docs
- **Tokens for proof**: spend extra tokens on independent critique + runnable verification, not on more planning prose

## Sub-skills (loaded by the mode)

| Skill | Role |
|---|---|
| `restatement` | Play back goal + problem in plain language before building |
| `write-spec` | Produce / refresh the single living spec |
| `cut-scope` | Hammer MVP; explicit non-goals |
| `vertical-slice` | Break work into click-testable increments |
| `build-outcome` | Implement one slice; decide plumbing without asking |
| `verify-outcome` | Run the app against acceptance; report pass/fail in plain words |
| `product-critique` | Adversarial check vs the spec (prefer a different model if available) |
| `dual-try` | Two short attempts at the same slice; keep the better outcome |
| `recover-wrong-turn` | Abort doc sprawl; revert + rewrite truth + fresh thread |
| `plain-status` | What changed, what waits on you, decidable from the reply alone |

## Principles (steering vocabulary)

Use these names when you want to steer without naming a skill:

- **one-source-of-truth**
- **decision-budget**
- **observable-acceptance**
- **vertical-slice**
- **cheap-reversal**
- **token-for-proof**
- **product-not-plumbing**

Example: `apply cheap-reversal. this slice is wrong — revert and rewrite the spec.`

## Mental model

```text
You (product gates)
    → /helm-mode
        → restatement / write-spec / cut-scope
        → vertical-slice
        → build-outcome ⇄ product-critique
        → verify-outcome  → you click pass/fail
        → next slice  |  recover-wrong-turn if the premise was wrong
```

## Not this pack

- Not a replacement for reading code when you want to become an engineer
- Not pstack: no perf forensics, PR babysitting fleets, or adversarial code-quality panels as the default
- Not ChatPRD: no external PRD SaaS required; the living spec is a local markdown file

## License

MIT
