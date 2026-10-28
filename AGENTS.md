# For coding agents

This repository is **helm-stack**: portable Agent Skills for commander-style AI development.

- Operator entry: instruct them to run `/helm-mode` (see `skills/helm-mode/SKILL.md`).
- Living product contract in consumer projects: `docs/helm-spec.md` (thin L0a). Optional working memory: `docs/helm-now.md` (L1).
- Design intent: humans gate product/UX/acceptance; **stronger models** gate engineering quality — do not delete quality practices to "simplify."
- Optional once: `/setup-helm` for per-role models.
- Do not add Cursor-only rules as the primary interface; skills must remain harness-portable.
- When editing skills, keep each `SKILL.md` focused; put long glossaries in `references/`.
