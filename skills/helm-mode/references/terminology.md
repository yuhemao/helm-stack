# Terminology for precise steering

Use these terms in the living contract, questions, and agent-to-agent briefs. They reduce ambiguity better than casual synonyms.

## Product & authority

| Term | Meaning | Prefer over |
|---|---|---|
| **Living product contract** / **Living spec** / **L0a** | One resolved product authority file (may be `docs/PRD.md` or `docs/helm-spec.md`): goal, non-goals, P0, observable ACs | "must be named helm-spec", "PRD folder as many authorities" |
| **helm.contract** | Tiny pointer file naming the L0a path | Duplicating PRD into helm-spec |
| **Thin PRD core** | Useful core of a PRD (what/not/accept); an existing PRD can *be* L0a | ChatPRD / multi-doc PRD rituals + a second copy |
| **Source of truth (product)** | Resolved L0a wins when chat and files disagree on product | "what we said earlier" |
| **Technical authority (L0b)** | Code + runnable checks | Parallel `architecture.md` as truth |
| **Working memory (L1)** | Optional `docs/helm-now.md` for active slice only | Second product bible |
| **Disposable (L2)** | Scratch plans, bakeoffs, chat essays — not authority | Syncing scratch into SoT |
| **Non-goals** | Explicitly out of scope for this version | "maybe later stuff" |
| **MVP** | Smallest shippable slice that proves the core job | "first version with many features" |
| **Scope hammer** | Cutting features to fit a fixed appetite | "simplify a bit" |
| **Appetite** | Time/complexity budget you are willing to spend | "how long it takes" |
| **P0 / P1 / P2** | Must-have / should / nice | "important-ish" |
| **Constraint** | Hard limit (stack, platform, budget, compliance) | "preference" |
| **Assumption** | Believed true without proof; must be labeled | silent guessing |
| **Open product question** | Unresolved item that blocks a **human** product gate | parking tech unknowns for the human |

## Acceptance & quality

| Term | Meaning | Prefer over |
|---|---|---|
| **Acceptance criterion (AC)** | Single observable pass/fail behavior | "should be nice to use" |
| **Observable acceptance** | Verified by seeing UI/API/state change | "code review says OK" |
| **Given / When / Then** | Context / action / outcome form for an AC | prose paragraphs |
| **Happy path** | Main success flow | "normal use" |
| **Edge case** | Rare but valid input/state | "weird stuff" |
| **Failure mode** | How the system behaves when something breaks | "if it errors" |
| **Definition of done** | Gate exit `PASS`: frozen ACs + envelope smokes green, no admitted Must open | "feels finished" |
| **Regression** | Previously passing behavior now fails | "something broke" |
| **Smoke test** | Minimal path proving the app stands up | "quick look" |
| **Oracle** | Independent check (tests, second model, human click) | author self-claim |
| **Eng critique** | Model-gate engineering adversarial review | asking the human to read the diff |
| **Product critique** | Model-gate AC review before build; runs once, then ACs freeze | cheerleading self-check; adding Musts after build |

## Acceptance gate (bounded loop)

| Term | Meaning | Prefer over |
|---|---|---|
| **Bounded loop** | Acceptance as a gate with tier, freeze, batch, envelope, budget and stop states | "keep fixing until it's perfect" |
| **Risk tier** | `simple` / `standard` / `high`, chosen by named triggers; sets agents, critique and budget | "non-trivial" by gut feel |
| **Trigger** | The named condition that put a slice in its tier (e.g. "schema migration") | "seems risky" |
| **Slice card** | Top of `docs/helm-now.md`: tier, frozen ACs, envelope, fix rounds, checkpoint, Deferred, stopped behaviors; pasted into every subagent brief | scattered notes |
| **AC freeze** | Slice ACs fixed at build start; only hard-risk findings may add Musts | moving the target during verify |
| **Regression envelope** | ≤3 named adjacent smokes, run in every collect round and re-verify | full P0 after every edit |
| **Collect round** | verify + eng-critique on one snapshot, no edits in between | fix-as-you-find |
| **Must admission** | A Must needs a frozen-AC violation with evidence, or a hard-risk scenario | critic opinion as blocker |
| **Hard risk** | security / authz, data loss, secret leak, irreversible damage | "could be a problem" |
| **Fix batch** | All admitted Musts handed to one build | one agent per finding |
| **Fix round** | One issued fix batch + its narrow re-verify; budget per tier in `acceptance-gate.md` §2 | "as needed" |
| **Progress / no-progress** | Progress = a batch item went FAIL→PASS and nothing went PASS→FAIL; otherwise stop now (oscillation → revert to checkpoint) | burning the rest of the budget |
| **Stop options** | A accept + defer / A′ switch off the risky part / B one more round / C change AC / D rethink | technical dump on the operator |
| **Carry-over rule** | A stopped behavior is not re-sliced for a fresh budget without the operator | "new slice, new budget" |
| **Slice base** | Commit recorded before a slice's first build; A′ / full-slice revert target | "the old version somewhere" |
| **Known gaps** | L0a section for stopped / switched-off behaviors needing root cause | hiding failures in Open questions |
| **Ledger line** | One line per finished slice in `helm-now.md` `## Ledger`: tier, agents, runs, rounds, exit | untraceable cost |
| **Checkpoint (fix)** | Commit made before each fix batch; revert target on oscillation | fixing forward on a broken state |
| **Deferred** | Findings moved out of the slice; product ones promoted once to L0a | losing findings / re-reviewing them |
| **AC-defect** | AC unreachable or contradictory; routes to change-direction, not a FAIL | fixing code toward an impossible AC |

## Delivery shape

| Term | Meaning | Prefer over |
|---|---|---|
| **Vertical slice** | Thin end-to-end increment that is demoable | "finish backend first" |
| **Horizontal layer** | One technical layer across many features | layering by default |
| **Increment** | One shippable step with its own ACs | "phase 2 vaguely" |
| **Spike / prototype** | Throwaway experiment to buy information | "start the real architecture" |
| **Baseline** | Known-good commit/state to revert to | "earlier somehow" |
| **Checkpoint** | Saved recoverable point (git commit) | unsaved wandering |
| **Reversible change** | Can be undone cheaply | "just try in prod" |
| **Irreversible change** | Deploy, delete data, charge money, public message | treating all edits equal |

## Agent workflow

| Term | Meaning | Prefer over |
|---|---|---|
| **Playbook** | Named step sequence for a job type | ad-hoc vibes only |
| **Router skill** | Main skill that loads others (`helm-mode`) | memorizing every skill |
| **Decision budget** | Human vs model vs act classification | asking everything |
| **Human gate** | Stop that needs the operator (scope/UX/acceptance/irreversible) | technical bike-shedding |
| **Model gate** | Technical judgment routed to stronger/independent models | asking the non-technical human |
| **Blind critique** | Reviewer does not see author rationalizations first | same agent grading itself warmly |
| **Dual-try / bakeoff** | Two short attempts; pick by outcome (ux or eng rules) | endless debate |
| **Fresh thread** | New chat with only L0a + current slice | infinite polluted context |
| **Context debt** | Accumulated docs/chats that make change expensive | "more documentation is safer" |
| **Premise failure** | Foundational assumption was wrong | "small bug" |
| **Recovery** | Revert + rewrite L0a + discard L1/L2 + rebuild | "fix forward forever" |
| **Test-time scaling** | Spend more samples/checks at inference to raise quality | one-shot hope |
| **Verifier** | Role that checks candidates against ACs | author saying done |
| **Harness** | Agent runtime: instructions + tools + model | "the AI app" vaguely |

## Stack vocabulary (enough to steer, not to code)

| Term | Meaning | Commander use |
|---|---|---|
| **Frontend** | What users see and click | "screens and flows" |
| **Backend / API** | Server logic and interfaces apps call | "rules and data access" |
| **Database** | Durable stored state | "what is remembered" |
| **Auth / authentication** | Proving who the user is | login/signup |
| **Authorization** | What that user is allowed to do | permissions |
| **Environment variable / secret** | Config and keys not hard-coded | "API keys live here" |
| **Deploy** | Publish a build for real users | going live |
| **Preview deploy** | Temporary URL for a change | try before production |
| **CORS** | Browser rule for cross-site API calls | common "frontend can't call backend" cause |
| **Migration** | Controlled database schema change | changing stored shape safely |
