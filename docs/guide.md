# helm-stack guide

## Who this is for

You want to build software with coding agents while controlling **requirements, UX/visual taste, direction, and acceptance** — not while reading diffs. Technical judgment should go to **stronger models**, not to you as a stand-in senior engineer. You tried heavy planning packs and got stuck aligning too many process docs mid-change.

## Quick start

1. Install the skills (`npx skills add …` or copy `skills/`).
2. Optional but recommended: `/setup-helm` to map builder / shaper / eng-critic / product-critic / verifier.
3. In a project folder:

```text
/helm-mode
Goal: …
Stack: …
I do not read code. You own implementation and engineering review via models.
Only ask me product/UX gates. Done when: …
```

4. Expect one living product contract (existing `PRD.md` / `spec.md` / `helm-spec.md` all OK; pin with `docs/helm.contract`), model-gated quality loops, and plain-language verify reports. Do **not** maintain two product-authority copies.

## Design intent

| Humans keep | Models keep |
|---|---|
| Requirements / scope | Shape before code |
| UX and frontend taste | Implementation |
| Final acceptance clicks | Eng critique + product critique |
| Irreversible / legal / money gates | Dual-try on eng forks; verify loops |

helm-stack does **not** mean "fewer quality practices." It means **quality practices stay, the reviewer is a model, the human stops being the tech auditor.**

## Docs: the right degree (L0 / L1 / L2)

| Layer | File | Role |
|---|---|---|
| L0a | Resolved path (`docs/helm.contract` → `PRD.md` / `spec.md` / `helm-spec.md` / …) | Thin living product contract (what / not / accept) — single product write-path |
| L0b | code + tests / verify | Technical authority |
| L1 | optional `docs/helm-now.md` | Active-slice working memory; discard on premise change |
| L2 | chat / `_scratch` | Disposable; never a second authority |

### Already have a PRD or spec?

Yes — compatible. `/helm-mode` boot should **adopt** that file (features + 验收/AC), pin `docs/helm.contract`, and **not** demand a new `helm-spec.md`. See `skills/helm-mode/references/living-contract.md`.

Poteto **pstack** is not PRD-centric ("best spec is code"). helm keeps a **thin** product write-path — which may literally be your existing PRD/spec file.

## Heritage vs poteto pstack

Kept: one router + playbooks, named principles, autonomy on reversible work, proof over vibes.

Changed: commander-facing vocabulary; technical escalation to **model gates**; thin L0a product contract for session portability; optional L1 instead of forbidding all persistence.

## When to spend more tokens

Buy oracles: `shape-before-code`, `eng-critique`, `product-critique`, `dual-try`, extra `verify-outcome`. Do not buy more planning chapters or tech interviews with the operator.

## Recovery mantra

Wrong early → **cheap-reversal** → rewrite L0a → discard L1/L2 → fresh thread → next slice.
