---
name: ps-dormammu-phase
description: >
  pstack: autonomously build ONE phase, with your steering. Use when I type
  /ps-dormammu-phase, or say "dormammu-phase <n>", "autonomously build phase 2", or
  "focus-build this phase: <context>". Runs the same unattended build -> QA ->
  fresh-context review -> commit loop and the same hard guardrails as
  /ps-dormammu-magic, but on the single phase I name, using the context I give it.
  The focused middle gear: more autonomous than /ps-build, narrower than
  /ps-dormammu-magic.
---

# Autonomous build of one phase (steered)

Build a single phase end to end without pausing, the way /ps-dormammu-magic builds the whole product — same loop, same guardrails — but scoped to the one phase I name and shaped by the steering context I pass in. This is the gear I reach for when I have time to aim it at one phase rather than turn it loose on everything.

## Input
I'll name the phase and usually give context: what to reuse, what to prioritise, gotchas, where the relevant docs are. Example: `/ps-dormammu-phase 3 reuse the existing ingest module; prioritise correctness over speed; the API contract is in docs/api.md`. Treat that context as binding direction for this build.

## What to do
1. Identify the phase in ROADMAP.md and open its spec file in specs/. If it still has `[OPEN: ...]` markers, stop and tell me to run /ps-clarify first.
2. Fold my steering context into how you build it.
3. Run the SAME loop as /ps-dormammu-magic, for this one phase only: set status in progress -> build to green -> QA loop (correctness, add regression tests) -> fresh-context review (apply clear fixes, flag judgment calls) -> tick the criteria in the spec file, set the phase's status to done in ROADMAP.md, update STATE.md, and commit.
4. Obey the SAME hard guardrails as /ps-dormammu-magic: one feature branch, never main, never merge/deploy/prod/secrets, no destructive git. Shipping stays mine (/ps-close).
5. Respect the phase's hardstop and the same stop conditions (iteration cap, no progress, a wall needing me). On stop, leave the same kind of report — scoped to this phase — and hand back to me.
