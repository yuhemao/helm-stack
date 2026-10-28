# Agent-internal engineering principles

These are **not** commander steering phrases. Apply them inside model gates (`shape-before-code`, `build-outcome`, `eng-critique`). Do not dump them on the operator.

When a leaf skill from pstack (or similar) is installed in the harness, prefer reading that skill. Otherwise treat these as short reminders:

| Reminder | Meaning |
|---|---|
| Prove it works | Verify the real artifact; compiles ≠ done |
| Fix root causes | Reproduce and trace before patching symptoms |
| Model the domain | Encode repeated rules in one structure, not scattered conditionals |
| Laziness / smallest change | Prefer deletion and the smallest change that meets ACs |
| Test behavior, not implementation | Assert what users/callers observe |
| Attack the premise | If multiple fixes share a failed premise, test the premise |
| Illegal states | Prefer shapes that make bad states hard to represent |
| Boundaries | Validate at edges; trust less outside |

helm-stack deliberately keeps **commander vocabulary** small (`decision-budget`, `thin-authority`, …) while still expecting these behaviors from builders and critics.
