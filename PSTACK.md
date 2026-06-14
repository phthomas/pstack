# PSTACK.md — how to drive pstack

> The activity map: which skill to run when. New here? See `EXAMPLE.md` for a worked walkthrough from a dump to a built product.

pstack is a set of Claude Code skills (all prefixed `ps-`) that wrap a spec-driven workflow: get the whole product clear up front, then build it — by hand, one steered phase at a time, or the whole thing unattended.

## Once per project (cold start)
1. Write `dump.md` — your brain dump of the whole product. Put real effort in; everything downstream is capped by it.
2. `/ps-dump-check` — the gate. Ready? If not, it hands you the gaps; flesh them out and re-run.
3. `/ps-sharpen` — an interview resolves the gaps -> `sharpened_dump.md`.
4. `/ps-bootstrap` — writes `PRODUCT.md` + `CLAUDE.md` + a `ROADMAP.md` index + one spec file per phase in `specs/`, covering EVERY phase of the product.
5. `/ps-clarify` — closes the open questions across ALL phase specs, so the product is fully specced before any building. This is your clarity bet.
6. `/ps-test` — tests from the acceptance criteria.

After that the product is specced: `ROADMAP.md` is the map, `specs/NN-*.md` is each phase's contract.

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
