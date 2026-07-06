# PSTACK.md — how to drive pstack

> The activity map: eight skills, one flow. New here? `EXAMPLE.md` is a worked walkthrough from a dump to a built product.

pstack wraps one workflow: braindump -> specced product -> built product, with shipping always yours. Eight skills, `ps-` prefixed; three of them do most of the work.

## The happy path
1. **Braindump into `dump.md`** — three loose headings, no structure required. Dictate if you can. Messy is the intended input.
2. **`/ps-start`** — gates the dump (too thin? it tells you exactly what's missing), interviews you on the gaps, then writes PRODUCT.md, CLAUDE.md, ROADMAP.md, and one spec per phase in specs/. One command for all three situations — it detects which:
   - blank repo -> specs the whole product;
   - existing codebase -> surveys the code *first*, then asks only what the code can't answer; writes or augments the docs, never overwriting;
   - live pstack project -> extends the plan with the new ideas.
3. **Build, at the autonomy you want:**
   - `/ps-build` — hands-on: one phase; resolves its open questions with you, writes its tests and shows them red for your check, then implements to green, pausing for steering.
   - `/ps-dormammu [mvp | N | N-M] [context]` — autonomous: pre-flights the open questions in one batch while you're still at the keyboard, then walks each phase (tests red -> build green -> QA -> fresh-context review -> commit) on a branch, never merging. No argument = every remaining phase.
4. **`/ps-close`** — verify criteria against the tests, review the diff (complete + clean), record ADRs, checkpoint, merge. The merge is yours.

## Every session
- Start: `/ps-resume` — reads ROADMAP.md, the active spec, STATE.md, and git; runs the tests; briefs you and proposes the next action. If STATE.md and reality disagree, it trusts git and the tests.
- Stop: `/ps-checkpoint` — overwrites STATE.md with the handoff. (`/ps-close` and `/ps-dormammu` run it themselves.)

## Changing the plan
- Fits in a sentence -> just say it: "add a phase for X", "re-open phase 2", "reorganize the order", "this approach isn't working". `/ps-spec` catches it — keeps ROADMAP.md and specs/ consistent, parks dropped ideas in BACKLOG.md, and records an ADR when the change is directional.
- Bigger than a sentence — a pile of ideas, a v2 -> braindump into `dump.md` again and run `/ps-start`; it extends the plan instead of starting over.
- A significant technical decision, made or reversed -> `/ps-adr` records the why (append-only; the other skills mostly trigger it for you).

## Design principles (why there's no step for X)
- **Conversation is the primary interface.** The slash commands are muscle-memory handles; every skill also triggers on plain intent ("build it", "ship it", "where were we").
- **Clarification is a behavior, not a stage.** /ps-start asks while drafting; /ps-build asks before coding its phase; /ps-dormammu asks once at pre-flight, then assumes-and-records the safe calls and hardstops on the load-bearing ones. `[OPEN: ...]` markers in later phases are healthy — they get answered at the last responsible moment, when you know the most.
- **Tests are not a step.** Each build gear turns the phase's acceptance criteria into red tests before implementing. "Done" stays executable; you never schedule it.
- **No skill where a sentence works.** An architecture sanity-check, doc grooming, a mid-phase code review — just ask for them. A skill exists only where there's a gate to enforce (/ps-start, /ps-close), a guardrail to hold unattended (/ps-dormammu), or file mechanics to keep consistent (/ps-spec, /ps-adr, /ps-checkpoint, /ps-resume).

## When something's wrong, match the fix to the magnitude
- A detail inside a phase -> say it while building; the spec gets updated as you steer.
- A phase's goal, order, or existence -> `/ps-spec`: re-scope, re-open, reorder, or park it in BACKLOG.md.
- The product direction or architecture -> `/ps-adr` the why, update PRODUCT.md / CLAUDE.md, then `/ps-spec` the new phases.
- A different product -> new repo.

## The artifacts
(Names are unbranded on purpose: `CLAUDE.md` is a Claude Code convention and must keep that name; the rest read clearer plain.)
- `dump.md` — the braindump inbox: new project, adopted codebase, or new ideas for a live one. Scratch; overwrite freely.
- `PRODUCT.md` — vision/why (slow). `CLAUDE.md` — how you build (slow). `AGENTS.md` — a two-line bridge pointing AGENTS.md-readers (Codex, pi, oh-my-pi) at CLAUDE.md.
- `ROADMAP.md` — the product map: every phase, its status, and a link to its spec. `/ps-dormammu` walks it.
- `specs/NN-*.md` — one per phase: the contract (requirements, acceptance-criteria checklist, hardstop). `[OPEN: ...]` markers welcome until the phase builds.
- `STATE.md` — where we are, next steps (per-session; the autonomous runs update it as they go).
- `docs/adr/` — decisions, append-only. `tests/` — enforced acceptance criteria. `BACKLOG.md` — parked tangents.

## Notes
- Steer any skill by pre-answering in the invocation: `/ps-dormammu 3 use DuckDB for storage; correctness over speed`.
- Calibrate: trivial fixes skip the pipeline entirely. The flow is for non-trivial, shippable work.
- The skills compose through files only (ROADMAP.md, specs/, STATE.md, tests/, git) — no hidden state. Stop, inspect, or re-run at any point.
