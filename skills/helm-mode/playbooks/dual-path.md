# Playbook: Dual path

High uncertainty. Buy information with two thin attempts. Only for `standard` or `high` slices — a `simple` change does not get a bakeoff. Agent counting and budget: `references/acceptance-gate.md` §9.

## Steps

1. **Restate + constrain** — Same goal, same stack, same appetite. Label the fork **ux-fork** or **eng-fork**. State the tier and its trigger.
2. **AC + freeze** — Write 2–4 shared observable ACs both paths must meet (patch L0a if product truth is involved). Freeze them in the slice card.
3. **Dual-try** — Run `dual-try` with that fork label.
4. **Verify both** — One `verify-outcome` per attempt, same rubric. No fix rounds on either attempt.
5. **Pick** — Eng-fork: one shared `eng-critique` across both + verify results; models pick; never ask the human. Ux-fork: present A/B to the operator only if both pass ACs and differ on taste.
6. **Keep one** — Delete or quarantine the loser; update living contract / `helm-now` as needed. The keeper continues with the slice's fix-round budget; its next collect round is verify-only if the shared eng-critique reviewed its code.
