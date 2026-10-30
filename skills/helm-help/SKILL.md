---
name: helm-help
description: "Orient the operator in helm-stack: which playbook, how to prompt /helm-mode, model gates vs human gates, how recovery works. Use for /helm-help. Does not start implementation."
license: MIT
disable-model-invocation: true
metadata:
  author: helm-stack
  version: "1.2.0"
---

# Helm help

Answer how to use helm-stack. **Do not start the product work.** Hand the operator one copy-pasteable prompt.

## Default answer

For almost all real work: use **`/helm-mode`** and describe the goal + done check. The mode loads sub-skills and runs model gates.

## Map

| Operator wants | Tell them |
|---|---|
| Start anything non-trivial | `/helm-mode` + goal + stack + done check |
| Only clarify requirements | `/helm-mode` + "spec only" |
| Already have PRD/spec, helm asks for helm-spec | Pin `docs/helm.contract` → that file; or say “L0a is docs/PRD.md — do not create helm-spec” |
| Something broken in the product flow | `/helm-mode` + "fix outcome" + what they clicked |
| Direction changed / earlier idea wrong | `/helm-mode` + "change direction" or "recover" |
| Just check if it works | `/helm-mode` + "verify only" |
| Two approaches unsure | `/helm-mode` + "dual path" + say UX vs technical uncertainty |
| Pick models for builder/critics | `/setup-helm` |
| Stop being asked jargon questions | Steer: `apply decision-budget` / `apply model-not-human-for-tech` |
| Docs/chat became a swamp | `/helm-mode` recover |
| Endless fix → re-check cycles, too many agents for a small change | Steer: `apply bounded-loop` (or `simple change` for tiny edits) |
| A slice stopped and offers A/B/C/D | Pick one; A (accept + defer) is usually right |

Read [`../helm-mode/SKILL.md`](../helm-mode/SKILL.md) and [`../helm-mode/references/prompting.md`](../helm-mode/references/prompting.md) before quoting details.

## Reply shape

1. One-sentence answer
2. One prompt in a code block
3. Optional: one principle name to apply
