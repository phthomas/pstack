---
name: ps-dormammu
description: >
  pstack: autonomous build — walk phases unattended: tests, build, QA,
  fresh-context review, commit, per phase. Use when I type /ps-dormammu, or say
  "dormammu", "dormammu magic", "build the whole thing", "build phase 3
  autonomously", "run it overnight", or "I'm out of time, build it all". Scope
  is the argument: nothing = every remaining phase, "mvp" = the MVP phases, a
  number or range = those phases; any text after the scope is binding steering
  context. Never merges — shipping stays mine via /ps-close.
---

# Dormammu — autonomous build (one phase, the MVP, or everything)

For when I'm not steering: build the phases in scope end to end and leave me a reviewed build plus a report, with only the merge decision left for me. This trades oversight for progress — the phase specs carry it. The guardrails below are not optional.

## Scope
- `/ps-dormammu` -> every phase in ROADMAP.md not yet done, in order.
- `/ps-dormammu mvp` -> the MVP phases. `/ps-dormammu 3` / `/ps-dormammu 2-4` -> those phases.
- Free text after the scope (`/ps-dormammu 3 reuse the ingest module; correctness over speed`) is binding steering context — fold it into how you build.

## Pre-flight (launch is the last attended moment — spend it)
Sweep the in-scope specs for [OPEN: ...] markers and untestably vague criteria. If any exist, ask me ONCE, in one batch, each with a recommended default (AskUserQuestion on Claude Code; plain text elsewhere), and write the answers into the specs. If I say "just go", or I don't engage, triage each item instead:
- Safe to assume — naming, formats, internal details, anything cheap to reverse -> take the most reasonable choice, record it in the spec marked "(assumed)", and continue.
- Load-bearing — data sources, auth, external contracts, money, security, anything expensive to reverse -> treat it as that phase's hardstop: stop there and report rather than guess.

## Hard guardrails (never break these, even unattended)
- One feature branch for the run: reuse the current branch if it's already a dedicated feature branch, otherwise cut a fresh one off main. NEVER work on or commit to main.
- NEVER merge, deploy, push to prod, or touch production systems or secrets.
- NEVER run destructive or irreversible commands: no force-push, no history rewrites, no deleting work that isn't yours.
- Commit per phase with clear messages, so I can review and bisect in the morning.
- Shipping stays mine: you build, QA, and review; I make the merge call with /ps-close.

## The loop, per phase in ROADMAP order
1. Set the phase to in progress in ROADMAP.md.
2. Tests from criteria: if the phase's acceptance criteria aren't covered yet, write one test per checkable criterion (in CLAUDE.md's framework, named so the criterion is obvious) and run them red — that red is the build target. If the phase touches existing code with thin coverage, first add characterization tests around the seams you're about to change, so regressions have something to trip.
3. Build to green, incrementally, per CLAUDE.md's conventions and the readability bar; build only what the phase asks. Don't pause for steering.
4. QA loop (correctness): run the full suite; hunt bugs, missing edge cases, and unmet criteria; add a regression test for each real issue; fix; re-run — until the criteria pass and a QA pass surfaces nothing material. Cap it at ~3-5 loops.
5. Review pass (quality), IN FRESH CONTEXT: a subagent or fresh session, so the reviewer isn't anchored on code it just wrote. The bar: simplicity (simplest thing that works, YAGNI), readability (clear in one pass), deletability (no dead code or needless layers), consistency (matches CLAUDE.md). Apply the clear must-fix simplifications and re-run the tests; note debatable judgment calls for the report rather than forcing them.
6. Tick the phase's criteria in its spec, set it done in ROADMAP.md, update STATE.md, commit.
7. Advance. Stop when scope is done or a stop condition trips.

## Stop conditions (don't thrash, don't burn the night)
- Scope done: every phase in scope passes QA and review.
- A phase fails hard: it can't be made to pass, or hits its hardstop — including a load-bearing open question the pre-flight couldn't settle. Stop there; don't build later phases on a broken foundation.
- No progress: the same failures keep recurring — stop rather than churn.
- A wall that needs me: anything that would require breaking a guardrail. Never break one to proceed.

## The morning report (this is the point)
When you stop, leave me:
- ROADMAP.md and the specs updated to reality: statuses and ticked criteria reflect what's actually true.
- STATE.md overwritten with the handoff (use /ps-checkpoint's structure): how far you got, where you stopped, what's next.
- A short report over every phase attempted: what got built; which criteria pass and which don't; what QA found and fixed; what the fresh-context review applied vs flagged for me; every assumption you made on your own (suggest /ps-adr where it matters); known issues and risks.
- Everything on the run branch, unmerged. Then it's my turn: read the report, deep-QA the flags, and /ps-close to ship — or /ps-spec more clarity into a phase and run you again.
