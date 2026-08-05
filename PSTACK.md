# PSTACK.md — how to drive pstack

> The activity map: eleven skills, one flow. New here? `EXAMPLE.md` is a worked walkthrough from a dump to a built product.

pstack wraps one workflow: braindump -> specced product -> built product, with shipping always yours. Eleven skills, `ps-` prefixed; three of them do most of the work.

## The happy path
1. **Braindump into `dump.md`** — three loose headings, no structure required. Dictate if you can. Messy is the intended input.
2. **`/ps-start`** — gates the dump (too thin? it tells you exactly what's missing), interviews you on the gaps, then writes PRODUCT.md, CLAUDE.md (with its `## Capabilities` map, probed from the real environment), ROADMAP.md, and one spec per phase in specs/. Where phases are independent it captures `Depends on:` + `Surface:`; where speed matters it pins a numeric budget. One command for all three situations — it detects which:
   - blank repo -> specs the whole product;
   - existing codebase -> surveys the code *first*, then asks only what the code can't answer; writes or augments the docs, never overwriting;
   - live pstack project -> extends the plan with the new ideas.
3. **Build, at the autonomy you want:**
   - `/ps-build` — hands-on: one phase; resolves its open questions with you, writes its tests (budgets and UI checks included) and shows them red for your check, implements to green, loops the mechanical gate (formatter, strict typecheck, scoped tests, benchmarks) until clean, then offers the panel — pausing for steering throughout.
   - `/ps-dormammu [mvp | N | N-M] [--parallel] [context]` — autonomous: pre-flights the open questions in one batch while you're still at the keyboard, then *conducts*: one fresh-context builder per phase, in dependency waves from the specs, parallel worktrees where `--parallel` and disjoint surfaces allow. Per phase: tests red -> build green -> gate -> panel -> commit, on a run branch, never merging. No argument = every remaining phase; no Coordination blocks in the specs = a linear run.
4. **`/ps-review`** — the panel, wherever a diff needs judging (the build gears invoke it themselves): fresh-context judgment, weighted by risk — one combined judge by default, splitting into separate judges (correctness per surface, parsimony, product with browser eyes on UI when available, security) only when the diff earns it: a security surface, a multi-surface diff, `Review: full` in the spec, or you asking. Must-fix / worth-considering / skip-it; the spec is the objective function and parsimony wins ties; every report ends with the manifest line of what actually ran, on which model tier.
5. **`/ps-close`** — verify criteria against the tests, review what ships (one integrated judge when every phase already closed clean; the full panel for parked or flagged work), record ADRs, checkpoint, merge. The merge is yours.

## Every session
- Start: `/ps-resume` — reads ROADMAP.md, the active spec, STATE.md, and git; runs the tests; briefs you (parked phases included) and proposes the next action. If STATE.md and reality disagree, it trusts git and the tests.
- Stop: `/ps-checkpoint` — overwrites STATE.md with the handoff. (`/ps-close` and `/ps-dormammu` run it themselves.)
- Occasionally: `/ps-doctor` — probe the environment, print the capability manifest, re-sync CLAUDE.md's map. Run it after installing a provider, or when a panel manifest line surprises you.
- After anything happened outside the skills (manual commits, another agent, a long gap): `/ps-init` — audits every doc against code, git, and the tests; reports the drift, repairs the mechanical items on one confirmation, and raises the judgment calls one by one. Reality wins; docs get corrected. (A bare repo with no docs is /ps-start's job, not init's.)

## Changing the plan
- Fits in a sentence -> just say it: "add a phase for X", "re-open phase 2", "reorganize the order", "this approach isn't working". `/ps-spec` catches it — keeps ROADMAP.md, specs/ (Coordination references included), and BACKLOG.md consistent, and records an ADR when the change is directional.
- Bigger than a sentence — a pile of ideas, a v2 -> braindump into `dump.md` again and run `/ps-start`; it extends the plan instead of starting over.
- A significant technical decision, made or reversed -> `/ps-adr` records the why (append-only; the other skills mostly trigger it for you).

## Design principles (why there's no step for X)
- **Conversation is the primary interface.** The slash commands are muscle-memory handles; every skill also triggers on plain intent ("build it", "ship it", "run the panel", "where were we").
- **Clarification is a behavior, not a stage.** /ps-start asks while drafting; /ps-build asks before coding its phase; /ps-dormammu asks once at pre-flight, then assumes-and-records the safe calls and hardstops on the load-bearing ones. `[OPEN: ...]` markers in later phases are healthy — they get answered at the last responsible moment, when you know the most.
- **Tests are not a step.** Each build gear turns the phase's acceptance criteria into red tests before implementing — performance budgets become failing benchmarks, UI criteria become Playwright checks. "Done" stays executable; you never schedule it.
- **Measurement over exhortation.** Wherever "write good code" could become a machine check (the gate) or an independent fresh-context verdict (the panel), it did. Advice-in-context is the weakest tool in the box; it's reserved for what can't be measured.
- **Capabilities live in the environment, never in the core.** The skills are markdown; reviewers, docs lookup, browser, canvas are providers, named once in CLAUDE.md's `## Capabilities` and resolved at runtime. A missing provider degrades a judge to its inline bar — visibly, in the manifest line, never silently.
- **Ceremony scales with risk; models follow task nature.** The panel is light by default and splits on stakes; panel fixes return to the phase's still-warm builder; spawned packs carry an output-discipline block so agents draft in files, not in their heads. The `model-tiers` line in Capabilities routes each spawn by what the task *is* (deep = judgment, prose craft, security · standard = routine building · mechanical = known fixes and re-checks — never by role name), with misclassification kept cheap: a failed agent retries one tier up, and the gate re-runs after mechanical work regardless (ADR 0006).
- **No skill where a sentence works.** An architecture sanity-check, doc grooming — just ask. A skill exists only where there's a gate to enforce (/ps-start, /ps-close), a guardrail to hold unattended (/ps-dormammu), a verdict to keep independent (/ps-review), file mechanics to keep consistent (/ps-spec, /ps-adr, /ps-checkpoint, /ps-resume, /ps-init), or an environment to make visible (/ps-doctor).

## More than one thing at once
- **Named dumps queue ideas**: `/ps-start dump-<topic>.md` — any file; a processed dump is spent, the specs are the record.
- **One working tree, one run.** Runs are `ps/<slug>` branches; a second `/ps-start` or `/ps-dormammu` moves itself to a sibling worktree off main first, then plans around the live run's claims (its branch's ROADMAP + specs say which phases and surfaces it owns). Git is the registry — `git worktree list` and `ps/*` branches; there's no state file to drift.
- **A dependency is satisfied only when its phase lands on main** (or was built earlier in the same run). Phases that need another run's unlanded work — or overlap its surfaces — park as blocked-by-that-run and report; the rest build. Runs land one at a time: /ps-close merges main in first, reconciles ROADMAP as a union, regenerates STATE.md, and names the phases that just unblocked.

## When something's wrong, match the fix to the magnitude
- A detail inside a phase -> say it while building; the spec gets updated as you steer.
- A phase's goal, order, or existence -> `/ps-spec`: re-scope, re-open, reorder, or park it in BACKLOG.md.
- The product direction or architecture -> `/ps-adr` the why, update PRODUCT.md / CLAUDE.md, then `/ps-spec` the new phases.
- The docs and the code disagree (work happened outside the skills) -> `/ps-init`: audit everything against git and the tests, repair with your sign-off.
- A judge keeps degrading -> `/ps-doctor` and install (or consciously skip) the provider.
- A different product -> new repo.

## The artifacts
(Names are unbranded on purpose: `CLAUDE.md` is a Claude Code convention and must keep that name; the rest read clearer plain.)
- `dump.md` — the braindump inbox: new project, adopted codebase, or new ideas for a live one. Scratch; overwrite freely.
- `PRODUCT.md` — vision/why (slow). `CLAUDE.md` — how you build + the `## Capabilities` map (slow). `AGENTS.md` — a two-line bridge pointing AGENTS.md-readers (Codex, pi, oh-my-pi) at CLAUDE.md.
- `ROADMAP.md` — the product map: every phase, its status, and a link to its spec. `/ps-dormammu` walks it, in waves.
- `specs/NN-*.md` — one per phase: the contract (requirements, acceptance-criteria checklist, optional Coordination and Performance budget, hardstop). `[OPEN: ...]` markers welcome until the phase builds.
- `STATE.md` — where we are, next steps (per-session; the autonomous runs update it as they go).
- `docs/adr/` — decisions, append-only. `tests/` — enforced acceptance criteria. `BACKLOG.md` — parked tangents. `CONTEXT.md` — the glossary, grown as domain vocabulary emerges.

## Notes
- Craft is borrowed, process is owned: builders' model-invoked moves (prototype, bug diagnosis, merge-conflict technique) come from providers named in the Capabilities map; pstack marks the moments (`[OPEN-SPIKE: ...]`) and routes the captures into its own artifacts via CLAUDE.md standing rules. Two of the upstream skills stay out — their `tdd` and `code-review` collide with ps-build's loop and ps-review's panel.
- Steer any skill by pre-answering in the invocation: `/ps-dormammu 3-5 --parallel use DuckDB for storage; correctness over speed`.
- Calibrate: trivial fixes skip the pipeline entirely. The flow is for non-trivial, shippable work.
- The skills compose through files only (ROADMAP.md, specs/, STATE.md, tests/, git) — no hidden state. Stop, inspect, or re-run at any point.
- Parallelism is a speedup, not a goal: most roadmaps are mostly chains, and the fresh-context builders are where most of the speed lives anyway. Declare surfaces only where phases are truly disjoint.
