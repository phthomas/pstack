---
name: ps-start
description: >
  pstack: the front door — turn a brain dump into a fully specced product. Use
  when I type /ps-start (optionally with a dump path: `/ps-start dump2.md`),
  when there's a dump file to process, or when I say "set
  this up", "initialize the project", "interview me", "sharpen this", "is my
  dump ready", "onboard this repo", "adopt pstack here", or — on a project
  that's already running — "I dumped new ideas, plan the next phases". Detects
  the situation itself (new project, existing codebase, or extending a live
  pstack project), gates the dump, interviews me on the gaps, then writes
  PRODUCT.md, CLAUDE.md (including its Capabilities map), ROADMAP.md, and one
  spec per phase in specs/. Safe to run while a /ps-dormammu run is mid-flight:
  it moves to a sibling worktree and shapes the new phases around the active
  run's claims.
---

# Start — dump in, specced product out

One command from mess to map. Read my dump, check it's enough, interview me on the gaps, then write the docs — every phase specced, ready to build. Sorting my thoughts is your job, not mine: expect the dump to be disordered, contradictory, and half-formed. That's the intended input, not a defect.

## Detect the situation (don't ask)
- ROADMAP.md already has real phases -> **extend**: new ideas for a live pstack project.
- The repo has real source code (beyond pstack's own scaffold and templates) -> **brownfield**: adopt pstack into an existing codebase.
- Otherwise -> **greenfield**: a new project.
Say which mode you detected; if I correct you, believe me.

## A run mid-flight in this tree? Move first, then plan around it
Before writing anything, check for an active run: `git worktree list`, branches matching `ps/*`, a branch with in-progress phases or uncommitted build state. If one is live:
1. **Don't touch its tree.** Create a sibling worktree off main — `git worktree add ../<repo>-<slug> -b ps/<slug> main` — and do everything (this planning and the build after it) there. If this harness can't work outside its launch directory, create the worktree and tell me to reopen the session in it; that one sentence is the whole cost.
2. **Read the active run's claims from its branch** — `git show <branch>:ROADMAP.md` and its in-scope specs: which phases it's building, which Surfaces they own.
3. **Shape the new phases around those claims.** Prefer disjoint Surfaces where the product genuinely allows. Where a new phase truly needs the active run's work, give it `Depends on:` that phase — a dependency counts as satisfied only when its phase is done AND landed on main, so /ps-dormammu parks such phases until the other run ships. Tell me plainly which new phases can build now and which wait.
4. **Append, never renumber.** While any run is live, existing phase numbers are load-bearing; new phases take the next numbers.

## Brownfield only: survey before you interview
Read the code first, so your questions are informed and my dump can stay thin: directory structure, build/config files (package.json, pyproject.toml, go.mod, ...), entry points, key module boundaries, existing tests and how to run them, any README or docs. Read the shape, not every line. The code is the source of truth for WHAT exists; the dump supplies the WHY and what's next. Never ask me something the code already answers.

## Gate the dump
Read dump.md — or the file I name (`/ps-start dump2.md`, `/ps-start dumps/alerts.md`; any markdown file works). Several dump files present and no argument? List them and ask which. A processed dump is spent — the specs become the record, so tell me it's safe to delete or archive it. The dump is ready when, from it plus any survey, you could answer:
1. What is this and why — an outcome, not just a topic?
2. What does done look like — at least a fuzzy notion of success?
3. What's fixed — the constraints and decisions already made?
Too thin to interview against? STOP: list exactly what's missing as concrete questions to answer in dump.md, and tell me to flesh it out and re-run. Never invent the missing content yourself — that defeats the gate.

## Interview
Close the gaps interactively — small batches, most consequential first, each with your recommended default and its tradeoff so I can confirm or redirect (AskUserQuestion on Claude Code; plain text elsewhere). Don't re-ask what the dump or the code already answers, and don't over-interview: the goal is an unambiguous ROADMAP and specs, not a complete requirements document. Decisions that only bite deep inside a later phase may stay open — the build skills raise them just-in-time.

While shaping the roadmap, also settle what the phases need *from each other*: where phases are genuinely independent, capture `Depends on:` and `Surface:` in their Coordination blocks so /ps-dormammu can wave and parallelize them; where the dump implies speed or scale matters, pin it as a numeric performance budget rather than an adjective. Both are optional — a linear map with no budgets is a fine answer; don't manufacture structure the product doesn't have.

## Write the docs
Interview answers land directly in the docs — no intermediate artifact. Show me the drafts before finalizing — in the plan canvas if `ecc-plan-canvas` is on PATH (open the drafts, block on the verdict), else inline.
- PRODUCT.md <- the vision: the problem, who it's for, the direction (the why).
- CLAUDE.md <- stack, test framework, architecture, conventions, standing rules — plus a `## Capabilities` section: probe the environment the way /ps-doctor does and map capability -> provider -> fallback, one line each (correctness review, parsimony review, product review, docs lookup, browser, gate tools, canvas). Write what's actually there, not what should be. Lean — about a page. Capabilities live in the environment, never in the core: this section is the one place providers are named; every other skill resolves against it and degrades gracefully.
- ROADMAP.md <- the index: a phases-at-a-glance table (status, in-MVP, spec link per phase) plus the MVP boundary.
- specs/NN-name.md <- one per phase, shaped like specs/_TEMPLATE.md: Goal, Coordination (optional), Requirements, Acceptance criteria, Performance budget (optional), Hardstop, Open questions, Out of scope. Spec EVERY phase, not just the first. UI-facing criteria name their Playwright check the way backend criteria name their pytest. Where something stays genuinely undecided, leave an [OPEN: ...] marker rather than guessing — then tell me the count, and that the build skills will ask when each phase starts.
- AGENTS.md <- a two-line bridge for AGENTS.md-reading agents (Codex, pi, oh-my-pi): read CLAUDE.md; start sessions with /ps-resume. Cheap insurance — Claude Code ignores it.
When unsure whether something is durable, put it in a phase spec, not CLAUDE.md/PRODUCT.md.

By mode:
- **Brownfield**: NEVER silently overwrite an existing doc — keep what's right, augment, and where a doc and the code disagree, flag it to me instead of clobbering. ROADMAP.md gets a short "current state" note plus the forward phases; do NOT retro-spec existing code (CLAUDE.md's architecture section is enough). Record the test baseline — if the existing suite is thin, say so in CLAUDE.md, so builds know to add characterization tests around whatever they touch. Optionally seed docs/adr/ with one or two ADRs for choices already baked into the code.
- **Extend**: read PRODUCT.md, ROADMAP.md, STATE.md, and a quick `git log --oneline -15` first — extend from reality, not just the plan: what's mid-flight, what a dormammu run parked, what actually shipped. Interview only about the delta. Append the new phases after the existing ones (new numbers, never renumbering); touch PRODUCT.md only if the direction genuinely moved — and say so if it did. Refresh the Capabilities section only if the environment changed.

## Hand off
There is no separate test step — the build skills turn each phase's criteria into red tests themselves. Point me at a gear: /ps-build (hands-on, one phase) or /ps-dormammu (autonomous — a phase, the MVP, or everything; waves and `--parallel` if the specs declare Coordination). Fresh machine? /ps-doctor shows what the build skills will actually find.
