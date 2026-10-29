# Resolve the living product contract (L0a)

L0a is **one write-path**, not a filename religion. **PRD** and **spec** docs are first-class: if either already holds product features + acceptance, that file **is** the living contract.

**Before any skill claims "missing helm-spec / missing spec":** run this resolver. Claiming missing while a PRD/spec with 验收/AC exists is a pack violation.

## Boot checklist (every `/helm-mode` start)

1. Resolve L0a (order below).
2. Say the path once under **Handled by models** (e.g. `L0a: docs/PRD.md`).
3. If unset, write `docs/helm.contract` when you adopt a file (so Codex/next session does not re-hunt).
4. Only then run restatement / write-spec / verify / build.

## Resolution order

1. **Explicit pointer** — `docs/helm.contract` (or `.helm/contract`): first non-empty, non-`#` line = repo-relative L0a path. Use it if the file exists.
2. **Operator-named path** — prompt says “use `docs/…/PRD.md`” / “spec is `…`”: that path wins; write `docs/helm.contract`.
3. **Default helm file** — `docs/helm-spec.md` if it is a **real** contract (has product + acceptance), not a pointer stub.
4. **Adopt existing PRD or spec** — scan candidates (below). Prefer **exactly one** strong candidate. Adopt in place. Pin with `docs/helm.contract`. **Do not** copy body into a new `helm-spec.md`.
5. **Create only if none** — thin `docs/helm-spec.md` via `write-spec`, then pin `docs/helm.contract`.

### Candidate paths (search in this order; stop at first exclusive strong hit when unique)

**PRD-shaped names**

- `docs/PRD.md`, `docs/prd.md`, `docs/Prd.md`
- `PRD.md`, `prd.md` (repo root)
- `docs/product-requirements.md`, `docs/product_requirement*.md`
- `docs/prd/*.md` when that folder has a single obvious main file (`README.md`, `index.md`, or one `*.md`)

**Spec-shaped names**

- `docs/helm-spec.md` (already covered in step 3)
- `docs/spec.md`, `docs/SPEC.md`, `spec.md`
- `docs/product-spec.md`, `docs/product_spec.md`
- `docs/living-spec.md`, `docs/product.md`
- `docs/requirements.md`, `docs/REQUIREMENTS.md`
- Paths containing `prd` or `spec` under `docs/` (depth ≤ 2), excluding obvious L2: `*_scratch*`, `archive/`, `_scratch/`, `node_modules/`

### Strong candidate (must pass)

A file is **strong** when it has **both**:

1. **Product intent** — goal / 目标 / 功能 / features / user stories / 范围 / non-goals / 非目标 / problem, etc.
2. **Acceptance** — 验收 / AC / acceptance / Given-When-Then / checklist / “Done when” / 通过标准 / testable bullets for user-visible behavior

Filename alone is not enough (e.g. empty `docs/spec.md`).

### Weak / ignore as L0a

- Pure tech design, API-only OpenAPI without product ACs, meeting notes, changelogs
- Multiple chapter files that are clearly a doc set **unless** one file is the hub and others are linked appendices (then hub is L0a; do not fork copies)

## When both PRD and spec exist

| Situation | Action |
|---|---|
| One strong, one weak/empty | Adopt the strong; pin `helm.contract`; leave or delete the weak |
| Both strong and content **overlaps** | **Human gate (1 question):** which file is the single authority? Pin that path. Do not merge into a third file unless operator asks |
| Both strong and clearly **split roles** (rare) | Prefer the one with acceptance as L0a; treat the other as L2 disposable or fold acceptance into L0a once — still one write-path |
| `helm-spec.md` is only a stub pointing at PRD | Follow the pointer; PRD is L0a |

**Never** keep PRD + helm-spec as two maintained authorities with copied sections.

## Section mapping (adopted PRD/spec — do not force rename)

When reading/updating an adopted doc, map flexibly:

| helm template idea | Common PRD / spec headings |
|---|---|
| Goal | 目标, Goal, Vision, Overview |
| Users | 用户, Personas, 受众 |
| Problem | 问题, Background, 背景 |
| Stack constraints | 技术栈, Constraints, Tech |
| Non-goals | 非目标, Out of scope, 不做什么 |
| User flows | 流程, User flow, 场景 |
| Capabilities P0/P1/P2 | 功能, Features, Scope, 范围 |
| Acceptance criteria | 验收, 验收标准, AC, Acceptance, Done when, 测试要点 |
| Failure modes | 异常, Errors, Edge cases |
| Open product questions | 待定, Open questions, TBD |

Prefer **patching acceptance in place** over rewriting the whole PRD into helm’s English outline.

## Pointer file

`docs/helm.contract`:

```text
# helm L0a path (repo-relative). One path.
docs/PRD.md
```

Also accept `.helm/contract` with the same format if `docs/helm.contract` is missing.

## Anti-patterns

- “Missing spec” while `docs/PRD.md` / `docs/spec.md` already has 验收
- Duplicating PRD into `helm-spec.md` “for helm”
- Syncing two files on every change
- Asking the operator to rename PRD → helm-spec when a pointer would do
