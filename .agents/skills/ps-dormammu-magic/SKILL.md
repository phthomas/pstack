---
name: ps-dormammu-magic
description: >
  pstack: autonomous, unattended build-QA-review loop over the WHOLE product. Use when
  I type /ps-dormammu-magic, or say "dormammu-magic", "build the whole thing",
  "one-shot the product", "run it overnight", or "I'm out of time, build it all".
  Walks every phase in ROADMAP.md — build, QA, tests, review, update status — on a
  feature branch, never merging or deploying, and leaves a morning report. Builds the
  full product. Only the ship decision is left to me. (For one phase, use
  /ps-dormammu-phase.)
---

# Autonomous whole-product build (unattended)

For when I can't steer — overnight, or away from the keyboard. Build the whole product by walking ROADMAP.md phase by phase, then leave me a full build to review and the one decision that's mine: whether to merge. This trades oversight for progress; I'm betting on the up-front clarity in the phase specs to carry it. The guardrails below are not optional. This skill is the canonical definition of the unattended loop — /ps-dormammu-phase reuses it for a single phase.

## Scope
- Default: the whole product — every phase listed in ROADMAP.md, in order.
- Narrower: if I say so, just the MVP phases or a phase range.
- Before starting, if any phase in scope still has `[OPEN: ...]` markers in its spec file, stop and tell me to run /ps-clarify — don't build on guesses.

## Hard guardrails (never break these, even unattended)
- Work on a single feature branch for the run: the current branch if it's already a dedicated feature branch, otherwise cut a fresh one off main. NEVER work on or commit to main.
- NEVER merge, deploy, push to prod, or touch production systems or secrets.
- NEVER run destructive or irreversible commands: no force-push, no history rewrite, no resetting or deleting work that isn't yours, no `rm -rf` outside the build dir.
- Commit per phase with clear messages, so I can review and bisect in the morning.
- Shipping stays mine: you build, QA, and review the whole product; I make the merge call with /ps-close.

## The loop (per phase, walked in ROADMAP order)
For each phase in scope, open its spec file in specs/ and:
1. Set the phase's status to in progress in ROADMAP.md.
2. Build to green — same method as /ps-build (read the phase's spec + CLAUDE + PRODUCT, run the tests red, implement to green incrementally, follow the readability bar, build only what the phase asks) — but don't pause for steering; proceed.
3. QA loop (correctness): run the full suite; hunt for bugs, missing edge cases, and unmet criteria; add a regression test for each real issue; fix and re-run, until the phase's criteria pass and a QA pass surfaces no new material issue.
4. Review pass (quality), IN FRESH CONTEXT: spin up a subagent / fresh review so it isn't anchored on the code it just wrote. Apply the /ps-staff-review lens (simplicity, readability, deletability, consistency). Apply the clear, must-fix simplifications and re-run the tests; note debatable judgment calls for the report rather than forcing them.
5. Update state: tick the phase's criteria in its spec file, set its status to done in ROADMAP.md, update STATE.md with where things stand, and commit the phase.
6. Advance to the next phase. Stop when scope is done or a stop condition trips.

## Stop conditions (don't thrash, don't burn the night)
Stop and write the report when any of these is true:
- Scope done: every phase in scope passes QA and review.
- A phase fails hard: it can't be made to pass, or hits its hardstop. Stop there and report — don't build later phases on a broken foundation.
- Iteration cap: ~3-5 QA loops on one phase. Don't polish forever; record what's left and stop.
- No progress: the same failures keep recurring — stop rather than churn.
- A wall I need to clear: a genuinely ambiguous decision the spec didn't settle, or anything that would require breaking a guardrail. For an ambiguous decision, make the most reasonable choice, write it down, and continue if safe; never break a guardrail to proceed.

## Morning report (this is the point)
When you stop, leave me:
- ROADMAP.md and the spec files updated: each phase's status and ticked criteria reflect reality.
- /ps-checkpoint -> STATE.md updated (how far you got, which phase you stopped at, what's next).
- A short build report covering every phase attempted: what got built, which phases and criteria pass and which don't, what QA found and fixed, what the fresh-context review flagged — split into applied (clear fixes) vs flagged-for-you (judgment calls) — any decision you made on your own (suggest /ps-adr where it matters), and known issues and risks.
- Everything on the feature branch, unmerged, ready for my review.

Then it's my turn: read the report, deep-QA the flagged items, and /ps-close to ship — or fix a phase with more clarity and run again.
