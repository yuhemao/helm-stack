# helm-stack

A portable **Agent Skills** pack for people who steer products with AI coding agents — without reading code.

Inspired by [pstack](https://github.com/cursor/plugins/tree/main/pstack)'s `/poteto-mode` design: **one main command**, the agent loads the right sub-skills.

**Design intent:** keep quality-raising engineering practices; move technical judgment from human experts to **stronger / independent models**. You keep requirements, UX/visual taste, and final acceptance.

Works in any harness that supports the [Agent Skills](https://agentskills.io) standard: Cursor, Claude Code, Codex, and others.

## Install

```bash
npx skills add yuhemao/helm-stack
```

Or copy the `skills/` folder into your agent skills directory.

Then, in chat:

```text
/helm-mode 我想做一个个人短链工具。技术栈 Next.js + Supabase + Vercel。我看不懂代码，你负责实现；技术审查用更强模型。只在产品取舍和体验上问我。
```

Optional once: `/setup-helm` to map builder / shaper / eng-critic / product-critic / verifier.

Stuck on which skill? `/helm-help`

## Remember one command

| You type | What happens |
|---|---|
| **`/helm-mode`** | Default entry. Matches a playbook, loads sub-skills, runs model gates. |
| `/setup-helm` | Configure which models own which roles. |
| `/helm-help` | Orientation only. Hands you a prompt; does not start the work. |

You usually do **not** need to memorize the rest. `helm-mode` routes to them.

## What this optimizes for

- **Thin product authority** (`docs/helm-spec.md`) — living product contract (PRD *core*: what / not / accept), not a document pyramid
- **Optional working memory** (`docs/helm-now.md`) — active slice only; discarded on premise change
- **Decision budget**: human gates vs **model gates** vs act — never interview you about libraries
- **Quality loop**: shape → build → **eng-critique** → product-critique → verify
- **Observable acceptance**: done means you can click a checklist
- **Cheap reversal**: rewrite L0a + discard L1/L2 + fresh thread — do not sync ten docs
- **Tokens for proof**: critique, dual-try, verify — not more planning prose

## Sub-skills (loaded by the mode)

| Skill | Role |
|---|---|
| `restatement` | Play back goal + problem before building |
| `write-spec` | Produce / refresh the thin living product contract |
| `cut-scope` | Hammer MVP; explicit non-goals |
| `vertical-slice` | Break work into click-testable increments |
| `shape-before-code` | Settle structure (model gate) before coding |
| `build-outcome` | Implement one slice |
| `eng-critique` | Independent engineering adversarial review |
| `product-critique` | Adversarial product check vs the contract |
| `verify-outcome` | Runnable / clickable pass/fail in plain words |
| `dual-try` | Two short attempts; UX or eng fork rules |
| `recover-wrong-turn` | Revert + rewrite L0a + discard L1/L2 + fresh thread |
| `plain-status` | Waiting on you vs Handled by models |
| `setup-helm` | Per-role model mapping |

## Principles (steering vocabulary)

- **one-source-of-truth** / **thin-authority**
- **decision-budget**
- **model-not-human-for-tech**
- **observable-acceptance**
- **vertical-slice**
- **cheap-reversal**
- **token-for-proof**
- **product-not-plumbing**

Example: `apply model-not-human-for-tech. pick the safer implementation via eng-critique.`

## Mental model

```text
You (product / UX / acceptance)
    → /helm-mode
        → restatement / write-spec / cut-scope
        → vertical-slice
        → shape-before-code → build-outcome
              ⇄ eng-critique  ⇄ product-critique
        → verify-outcome → you click when needed
        → next slice  |  recover-wrong-turn if the premise was wrong
```

## Docs degree (not "zero docs", not "doc pyramid")

| Layer | Meaning |
|---|---|
| L0a `docs/helm-spec.md` | Single product write-path |
| L0b code + checks | Technical authority |
| L1 `docs/helm-now.md` | Optional disposable working memory |
| L2 scratch | Never authority |

## Not this pack

- Not a replacement for learning to read code if that is your goal
- Not poteto pstack's full engineering fleet (perf forensics, PR babysit autopilot, etc.) — those remain optional outside this commander pack
- Not an enterprise PRD SaaS / multi-doc PRD stack; the living contract is one thin local markdown file
- Not "skip eng review because the user is non-technical" — review moves to **models**

## License

MIT
