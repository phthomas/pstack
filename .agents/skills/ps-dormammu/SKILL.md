---
name: ps-dormammu
description: >
  pstack: autonomous build — a thin conductor walks phases unattended, one
  fresh-context builder per phase, in dependency waves, parallel where the
  specs allow: tests red, build green, mechanical gate, review panel, commit,
  per phase. Use when I type /ps-dormammu, or say "dormammu", "dormammu
  magic", "build the whole thing", "build phase 3 autonomously", "run it
  overnight", "build 4 and 5 in parallel", or "I'm out of time, build it all".
  Scope is the argument: nothing = every remaining phase, "mvp" = the MVP
  phases, a number or range = those phases; `--parallel` allows concurrent
  phases in worktrees where surfaces are disjoint; any other text is binding
  steering context. Never merges to main — shipping stays mine via /ps-close.
---

# Dormammu — autonomous build (one phase, the MVP, or everything)

For when I'm not steering: build the phases in scope end to end and leave me a reviewed build plus a report, with only the merge decision left for me. This trades oversight for progress — the phase specs carry it. The guardrails below are not optional.

**You are the conductor, not the builder.** Hold only the map (ROADMAP.md), the wave state, and the growing report. Each phase is built by a fresh-context worker you spawn (a subagent via the Task tool on Claude Code; a fresh session elsewhere) — late phases get the same clear head as early ones, and the run's context never silts up with earlier phases' diffs. No subagent mechanism at all? Run the loop yourself, but reload only the current phase's pack each time and keep the rest of the run out of your head.

## Scope
- `/ps-dormammu` -> every phase in ROADMAP.md not yet done. `/ps-dormammu mvp` -> the MVP phases. `/ps-dormammu 3` / `/ps-dormammu 2-4` -> those phases.
- `--parallel` -> phases in the same wave may run concurrently, each in its own worktree — only where every pair of Surfaces is declared and disjoint. Without the flag, waves still order the run but phases execute one at a time. When in doubt, sequential: parallelism is a speedup, not a goal.
- Any other text after the scope (`/ps-dormammu 3 reuse the ingest module; correctness over speed`) is binding steering context — fold it into every builder's pack.

## Pre-flight (launch is the last attended moment — spend it)
1. Sweep the in-scope specs for [OPEN: ...] markers and untestably vague criteria. If any exist, ask me ONCE, in one batch, each with a recommended default (AskUserQuestion on Claude Code; plain text elsewhere), and write the answers into the specs. Builders can't ask mid-run — this batch is why. [OPEN-SPIKE: ...] markers are different: they're the builder's to answer with a throwaway prototype, so don't raise them here — unless the craft capability is absent, in which case treat them as ordinary [OPEN: ...] items. If I say "just go", or I don't engage, triage each item instead:
   - Safe to assume — naming, formats, internal details, anything cheap to reverse -> take the most reasonable choice, record it in the spec marked "(assumed)", and continue.
   - Load-bearing — data sources, auth, external contracts, money, security, anything expensive to reverse -> treat it as that phase's hardstop: stop there and report rather than guess.
2. Resolve capabilities: read CLAUDE.md `## Capabilities` (probe as /ps-doctor does if it's missing or stale). Note what this run has — reviewers, parsimony, docs, browser, gate tools — and what degrades; it becomes each phase's manifest line.
3. Compute the waves from the specs' `Depends on:` lines, topologically. A spec with no Coordination block depends on the previous phase — no blocks anywhere means a linear run, exactly as v1. **A dependency counts as satisfied only when its phase is done AND landed on main, or built earlier in this same run.**
4. Other runs: check `git worktree list` and branches matching `ps/*`. If this tree already hosts a live run, move yourself to a sibling worktree off main first (as /ps-start does) — one tree, one run. Phases depending on another run's unlanded work, or whose Surface overlaps an active run's claimed surfaces (read its branch's ROADMAP and specs), get parked as blocked-by-that-run: reported, not built, not counted as failures. Their descendants park with them; everything else proceeds.
5. If `ecc-plan-canvas` is on PATH and I'm still at the keyboard, offer the in-scope specs in the canvas for a last annotated look; otherwise the typed pre-flight was the gate.

## Hard guardrails (never break these, even unattended)
- One feature branch for the run, named `ps/<slug>` (a short slug from the scope — `ps/alerts`, `ps/mvp-0729`): reuse the current branch if it's already a dedicated feature branch, otherwise cut a fresh one off main. NEVER work on or commit to main.
- Worktrees are run-branch discipline: each parallel phase gets a worktree on a child branch (`ps/<slug>/NN`) cut from the run branch; children merge only back into the run branch and are pruned after. Nothing ever merges to main.
- NEVER merge to main, deploy, push to prod, or touch production systems or secrets.
- NEVER run destructive or irreversible commands: no force-push, no history rewrites, no deleting work that isn't yours.
- Commit per phase with clear messages, so I can review and bisect in the morning.
- Shipping stays mine: you build, gate, and review; I make the merge call with /ps-close.

## The loop, per wave
Take the next wave. For each phase in it (concurrently only under the `--parallel` conditions above), spawn a builder with a curated pack — the phase's spec, CLAUDE.md, PRODUCT.md's vision in a paragraph, the steering context, the ADRs that touch this phase, and the parsimony bar (ponytail if installed) — and these instructions. The craft skills named in Capabilities are the builder's to invoke when the situation matches — an [OPEN-SPIKE: ...] marker, a bug that resists the gate loop, a conflicted merge — with captures landing in pstack artifacts per CLAUDE.md's standing rule; prototype's own unattended fallback (state the assumption, match the surrounding code) applies since there's no one to ask.

1. Set the phase to in progress in ROADMAP.md.
2. Tests from criteria: if the phase's acceptance criteria aren't covered yet, write one test per checkable criterion (in CLAUDE.md's framework, named so the criterion is obvious) and run them red — that red is the build target. A performance budget is a criterion: write the failing benchmark. A UI criterion is a criterion: write the Playwright check. If the phase touches existing code with thin coverage, first add characterization tests around the seams you're about to change, so regressions have something to trip.
3. Build to green, incrementally, per CLAUDE.md's conventions and the readability bar; build only what the phase asks. When an API belongs to a fast-moving library, climb the docs ladder — installed source first (version-exact), then official docs via websearch + webfetch — rather than memory. Don't pause for steering — there's no one to steer.
4. Gate loop, machine first: formatter, strict typecheck, the phase-scoped tests, the budgets — fix and repeat until clean, adding a regression test for each real bug. Run the FULL suite once at the end of the phase, not every iteration. Cap the hunt at ~3-5 loops.
5. Panel: run /ps-review on the phase diff — correctness per surface, parsimony, product (browser eyes if the capability is there), security if triggered, all fresh-context. Fix the must-fixes, re-gate, re-review the deltas — at most 3 cycles, then park the phase with its findings flagged. Arbitration is /ps-review's rule: the spec is the objective function; parsimony wins ties.
6. Tick the phase's criteria in its spec, set it done in ROADMAP.md, commit on the phase's branch, and return the phase result: criteria status, commits, assumptions marked "(assumed)", any spikes run (question -> verdict, throwaway-branch pointer), the panel's manifest line, flags.

Then close the wave: merge its phase branches into the run branch in phase order; run the full suite once as the integration gate — a red integration gate is a failed wave: stop and report rather than patch blind; prune the worktrees; fold the phase results into the report; advance to the next wave.

## Stop conditions (don't thrash, don't burn the night)
- Scope done: every phase in scope passed its gate and its panel.
- A phase fails hard: it can't be made to pass, hits its hardstop — including a load-bearing open question the pre-flight couldn't settle — or parks at the review cap. Its DESCENDANTS don't build; independent phases in scope still may.
- No progress: the same failures keep recurring — stop rather than churn.
- A wall that needs me: anything that would require breaking a guardrail. Never break one to proceed.

## The morning report (this is the point)
When you stop, leave me:
- ROADMAP.md and the specs updated to reality: statuses and ticked criteria reflect what's actually true.
- STATE.md overwritten with the handoff (use /ps-checkpoint's structure): how far you got, where you stopped, what's next.
- A short report over every phase attempted: what got built; which criteria pass and which don't; what the gate caught; what the panel applied vs flagged — including anything parked at the review cap or blocked by another run, with its findings; every assumption made unattended (suggest /ps-adr where it matters); known issues and risks; and the phase's manifest line — which judges ran with which providers, what degraded and why. Plus one line for the run: the waves as executed, parallel or not.
- Everything on the run branch, unmerged. Then it's my turn: read the report, deep-QA the flags, and /ps-close to ship — or /ps-spec more clarity into a phase and run you again.
