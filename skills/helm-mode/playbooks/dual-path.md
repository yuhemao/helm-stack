# Playbook: Dual path

High uncertainty. Buy information with two thin attempts.

## Steps

1. **Restate + constrain** — Same goal, same stack, same appetite. Label the fork **ux-fork** or **eng-fork**.
2. **AC** — Write 2–4 shared observable ACs both paths must meet (patch L0a if product truth is involved).
3. **Dual-try** — Run `dual-try` with that fork label.
4. **Verify both** — `verify-outcome` rubric applied to each.
5. **Pick** — Eng-fork: models + `eng-critique` pick; never ask the human. Ux-fork: present A/B to the operator only if both pass ACs and differ on taste.
6. **Keep one** — Delete or quarantine the loser; update living contract / `helm-now` as needed; continue with normal slices (including eng-critique on the keeper if not already done).
