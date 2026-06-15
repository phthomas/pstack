# PSTACK.md — how to drive pstack

> The activity map: which skill to run when. New here? See `EXAMPLE.md` for a worked walkthrough from a dump to a built product.

pstack is a set of Claude Code skills (all prefixed `ps-`) that wrap a spec-driven workflow: get the whole product clear up front, then build it — by hand, one steered phase at a time, or the whole thing unattended.

## Once per project (cold start)
Get it clear first — the same clarity-first front-end whether the project is new or already has code:
1. Write `dump.md` — your brain dump. New project: the idea, the why, what "done" looks like. Existing codebase: orient the agent — where to look, what to ignore, why it exists, what you want next.
2. `/ps-dump-check` — the gate. Ready? If not, it hands you the gaps; flesh them out and re-run.
3. `/ps-sharpen` — an interview resolves the gaps -> `sharpened_dump.md`.

Then turn that into the project's docs — this step forks on whether code already exists:
- New project -> `/ps-bootstrap` — writes `PRODUCT.md` + `CLAUDE.md` + a `ROADMAP.md` index + one spec per phase in `specs/`.
- Existing codebase -> `/ps-adopt` — surveys the code (guided by the sharpened dump) and writes or augments the same docs, reconciling with any that already exist rather than overwriting.

Picked the wrong one? Each checks the project state and redirects you: `/ps-bootstrap` in a repo that already has code sends you to `/ps-adopt`; `/ps-adopt` in an empty repo sends you to `/ps-bootstrap`. It's a heuristic with an override — confirm and it proceeds anyway.

Then, both paths:
4. `/ps-clarify` — close the open questions across ALL phase specs. This is your clarity bet.
5. `/ps-test` — tests from the acceptance criteria.

After that the product is specced: `ROADMAP.md` is the map, `specs/NN-*.md` is each phase's contract.

## Every session
Opening a fresh session on an existing pstack project? Run `/ps-resume` first — it reads `ROADMAP.md`, the active spec, `STATE.md`, git, and the tests, then briefs you on where things stand and the next action before any building. (It's the load-side bookend to `/ps-checkpoint`, which saves the handoff at session end.)

## Three gears for building it
Same loop underneath; pick the autonomy you want.
- `/ps-build` — interactive: implement a piece of the current phase, pausing so you can steer. Hands-on. Ticks criteria in the phase's spec as they pass.
- `/ps-dormammu-phase <context>` — autonomous on ONE phase you name, shaped by the context you pass in. The focused gear, for when you have time to aim it.
- `/ps-dormammu-magic` — autonomous over the WHOLE product: walks every phase in `ROADMAP.md` (build -> QA -> tests -> fresh-context review -> update status + `STATE.md` -> commit -> next), on a feature branch, never merging. Leaves a morning report and a full build. For when you're out of time.

All three stop at the same place: `/ps-close`. Shipping is always your call.

## Close the loop
1. `/ps-staff-review` — code-quality review against the readability/simplicity bar (the dormammu skills run this in fresh context themselves).
2. `/ps-revise` — if a hypothesis turns out wrong mid-build, correct the phase's spec and keep going.
3. `/ps-close` — verify the phase (or whole build), review, merge, mark phases done in `ROADMAP.md`. After a dormammu run, this is your deep-QA pass over the flagged items.

## As needed
- `/ps-spec` — add a new phase, or revise/re-open one (the phases are specced up front; this changes the plan later).
- `/ps-clarify` — re-run any time open questions appear; point it at one phase or let it sweep all.
- `/ps-review` — zoom out on strategy/architecture; confirms the direction or flags risks with alternatives.
- `/ps-adr` — record a significant or architectural decision (append-only).
- `/ps-checkpoint` — overwrite `STATE.md` with a clean handoff.
- `/ps-groom` — keep `CLAUDE.md` lean; move detail to where it belongs.

## When something's wrong, match the fix to the magnitude
- A detail inside a phase -> `/ps-revise` (or `/ps-clarify` if it was never decided).
- A phase's goal is wrong -> `/ps-spec` re-open or re-scope it (or split it); park the old idea in `BACKLOG.md`.
- The product direction or architecture -> `/ps-adr` the why, update `PRODUCT.md` / `CLAUDE.md`, then `/ps-spec` the phases of the new direction.
- A different product -> new repo.

## The artifacts
(Names are unbranded on purpose: `CLAUDE.md` is a Claude Code convention and must keep that name; the rest read clearer plain.)
- `dump.md` / `sharpened_dump.md` — scratch + provenance (cold-start only).
- `PRODUCT.md` — vision/why (slow). `CLAUDE.md` — how you build (slow).
- `ROADMAP.md` — the product map: every phase, its status, and a link to its spec. `/ps-dormammu-magic` walks it.
- `specs/NN-*.md` — one per phase: the contract (requirements, acceptance-criteria checklist, hardstop). The build skills open just the phase they're working on.
- `STATE.md` — where we are, next steps (per-session; the dormammu skills update it as they go).
- `docs/adr/` — decisions, append-only. `tests/` — enforced acceptance criteria. `BACKLOG.md` — parked tangents.

## Notes
- Skills compose: `/ps-bootstrap`, `/ps-close`, and `/ps-dormammu-magic` orchestrate the smaller ones; `/ps-dormammu-phase` reuses `-magic`'s loop on one phase.
- Steer a skill by pre-answering in the invocation, e.g. `/ps-clarify use DuckDB for storage because it's already in our stack`.
- Calibrate: trivial fixes skip the pipeline entirely. The flow is for non-trivial, shippable work.
