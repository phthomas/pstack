# Changelog

## 2.3.1 — the mechanical floor

- **Mechanical defaults to the rung one below the session model — the same rung as standard, not two below.** Small models flail on real edits, and a flailing fixer costs more than it saves. The tier's identity is its discipline, its escalation semantics, and low reasoning effort where that knob exists — not necessarily a different model; map it lower only for genuinely deterministic chores. Retry semantics refined to match: a failed agent escalates to the next *distinct* tier up.
- **Thinking inheritance documented.** Spawned agents inherit the session's reasoning effort on most harnesses — there is no per-spawn thinking knob (Claude Code's Task tool takes a model, not a thinking budget) — so the packs' output-discipline block is the real control: it bounds thinking by bounding the work unit. Where a per-spawn effort knob exists, it tiers like the models (deep inherits, mechanical low). /ps-doctor now probes for the knob. ADR 0006 stands unedited — it pinned deep = session model and deliberately left the lower rungs to the map.
- **`scripts/agent-models.sh`** — neither the Claude Code CLI nor the desktop app displays which model a running subagent is on, so this reads Claude Code's own transcripts and prints agent -> model per spawn: the ground truth that audits the manifest lines' self-reported tiers. Claude Code only; on other harnesses it finds no transcripts and exits cleanly — nothing anywhere auto-runs it. Optional diagnostic, never load-bearing.

## 2.3.0 — the proportionality release

2.0 bought certainty at headcount prices; this release makes the ceremony proportional to the risk — and keeps agents alive on prose-heavy phases (ADR 0006). Born from a real run: 27 subagents and 5h38m for a five-phase MVP, seven agent deaths at the 64k output cap, all runaway thinking on prose work.

- **Panel weight** — /ps-review now defaults to ONE combined fresh-context judge carrying all the bars in a single read of the diff; the split panel runs on triggers only: a security surface, a multi-surface diff, `Review: full` in the spec, a close over parked or flagged work, or the operator asking. Fresh context stays non-negotiable; headcount doesn't.
- **Fixes return to the builder** — panel must-fixes resume the phase's builder (its context is still warm; SendMessage on Claude Code) or the conductor applies the trivially mechanical ones itself; a fresh fix agent is the last resort. The role that re-bought a phase's whole context to apply twelve known edits is gone. The panel is explicitly the conductor's step — a spawned builder can't spawn judges.
- **Output discipline, in every pack** — spawned agents work file-by-file, never restate a whole file in prose or thinking, draft deliverables in the file with incremental edits, and tool-call early with at most a sentence or two between calls. An agent that still overflows gets resumed with smaller work units, never respawned from scratch. The morning report now accounts for deaths and resumes.
- **`model-tiers`** — an optional Capabilities line mapping task nature -> model, never role -> model: deep (design, judging, prose craft, security) = the session model; standard (routine building against a clear spec); mechanical (known fixes, recounts, delta re-checks). Specs can mark `Complexity: hard`; a failed agent retries once one tier up; the gate re-runs after mechanical work regardless; manifest lines say which tier ran. No per-spawn model selection in the harness = everything on the session model, visibly.
- **Lighter close** — /ps-close weighs its review by what already ran: every phase 0-must-fix under the run's panels -> one integrated judge over the final tree; parked or flagged work -> the full panel. /ps-dormammu no longer pre-runs any close review — the close panel is attended, and shipping stays the operator's.

## 2.2.0 — the craft release

Builders gain *moves*, not just gates and judges — borrowed, not built (ADR 0005): process is user-invoked and owned; craft is model-invoked and provided.

- **The `craft` capability** — a curated [mattpocock/skills](https://github.com/mattpocock/skills) subset (`prototype`, `diagnosing-bugs`, `resolving-merge-conflicts`, `domain-modeling`, `research`) named in CLAUDE.md's Capabilities map. Builders in /ps-build and /ps-dormammu invoke them when the situation matches; excluded: upstream `tdd` and `code-review` (they collide with ps-build's loop and ps-review's panel — /ps-doctor flags them if found model-invocable) and the tracker-substrate planners (`wayfinder`, `to-tickets`, `triage`).
- **`[OPEN-SPIKE: ...]`** — a spec marker for questions a throwaway prototype answers better than the human ("does this state model feel right?"). Builders answer them with the prototype skill; dormammu's pre-flight leaves them alone (no craft installed = they degrade to ordinary `[OPEN: ...]`). Phase results and the morning report record spikes run (question -> verdict, throwaway-branch pointer).
- **Adaptation in pstack's layer only** — a CLAUDE.md standing rule routes prototype captures into pstack artifacts (spec + ADR, not an issue tracker); provider files are never edited, so resyncs stay clean diffs.
- **`CONTEXT.md`** — adopted as the glossary artifact (ubiquitous language with `_Avoid_:` synonym bans), grown by /ps-start's interview as domain vocabulary emerges; upstream skills that read CONTEXT.md get it for free.
- **`/ps-init`** — the eleventh skill: audit and realign every pstack artifact (CLAUDE.md, PRODUCT.md, ROADMAP.md, specs/, STATE.md, ADRs, CONTEXT.md) against the codebase, git history, and tests. Detects greenfield / brownfield / live-pstack first; repairs mechanical drift on one confirmation, raises judgment calls one by one; ADRs stay append-only (contradictions become superseding ADRs, never edits). Repairs only — a bare repo hands off to /ps-start.
- **Selective craft install** — the README now documents install-by-name (`npx skills add mattpocock/skills --skill prototype --skill ...`): the excluded skills never land, instead of landing and needing removal. Multi-agent via the CLI's `-a claude-code -a codex -a opencode` flags.
- **OpenCode support** — OpenCode reads `.claude/skills/` and `.agents/skills/` natively (project and home level), so pstack's existing trees serve it with no extra step; documented alongside Codex, pi, and oh-my-pi.

## 2.1.0 — the continuity release

Products get fed, not finished — and sometimes fed twice at once. 2.1 gives runs identity and makes both continuity scenarios first-class (ADR 0004).

- **Named dumps** — `/ps-start dump2.md` (any path); several queued dump files and no argument, it asks which. A processed dump is spent: the specs are the record; delete or archive it.
- **Extend from reality** — extend mode now reads STATE.md and recent git history alongside PRODUCT/ROADMAP, so new phases start from what's actually mid-flight and shipped, not just the old plan.
- **Concurrent runs** — one working tree, one run: a second `/ps-start` or `/ps-dormammu` moves itself to a sibling worktree off main (`ps/<slug>` branches; git is the registry — no state file). Planning reads the active run's branch for its claimed phases and Surfaces and shapes the new phases around them.
- **Cross-run blocking for free** — a `Depends on:` is satisfied only when its phase is done AND landed on main (or earlier in the same run). Phases needing another run's unlanded work — or overlapping its claimed surfaces — park as blocked-by-that-run, with their descendants; the rest build.
- **Land order** — `/ps-close` merges main into the run branch before the panel when another run landed first: ROADMAP reconciles as a union of rows (each run authoritative for its own phases), STATE.md is regenerated rather than merged, the full suite re-runs, and the close notes which parked phases just unblocked.
- **Guards and visibility** — ROADMAP is append-only while any run is live (`/ps-spec` refuses renumbering and under-the-feet revisions); `/ps-resume` briefs on other live runs, their claims, and what they block.

## 2.0.0 — the execution release

v1 collapsed the ambiguity before the build; 2.0 upgrades the build itself. pstack stays pure markdown — everything with a runtime is a *capability provider* the skills detect, use, and degrade without (visibly, never silently).

### New skills
- **`/ps-review`** — the review panel: independent fresh-context judges over the diff — correctness per surface, parsimony (over-engineering), **product** (built vs specced, against PRODUCT.md and the phase criteria; browser eyes on UI phases when available), security when triggered. Must-fix / worth-considering / skip-it; the spec is the objective function, parsimony wins ties; every report ends with a provider manifest line.
- **`/ps-doctor`** — probe the environment, print the capability manifest with an install hint per gap, and sync CLAUDE.md's `## Capabilities` map.

### Changed
- **`/ps-dormammu`** — rebuilt as a thin conductor: one fresh-context builder per phase (late phases get a clear head; the run's context never silts up); dependency **waves** from the specs' `Depends on:` lines; `--parallel` runs a wave's phases in worktrees when their `Surface:` declarations are disjoint; a failed phase blocks only its descendants; the wave merges into the run branch in order behind a full-suite integration gate. Review step is now the `/ps-review` panel, capped at 3 fix cycles before parking. The morning report gains per-phase manifest lines and the wave summary. Guardrails unchanged — one run branch, never merge to main, commit per phase, shipping stays yours.
- **Docs grounding is a ladder, not an MCP** — the build skills ground fast-moving library APIs by reading the *installed source* first (venv / `node_modules`, version-exact by construction), then official docs via the harness's websearch + webfetch; docs CLIs are optional convenience. No third-party registry sits in the default path — no version drift, no always-on injection surface, no tool-schema tax (ADR 0003).
- **`/ps-build`** — reads the Capabilities map; performance budgets and UI criteria become red tests like everything else; adds the **mechanical gate** (formatter, strict typecheck, phase-scoped tests, benchmarks) before any review attention; offers the panel at phase end.
- **`/ps-close`** — the review step now runs the `/ps-review` panel over everything being closed; verification runs budgets too.
- **`/ps-start`** — interviews for phase independence (`Depends on:` + `Surface:`) and numeric performance budgets where the dump implies them (both optional); generates CLAUDE.md's `## Capabilities` section from a real probe of the environment; shows drafts in the plan canvas when `ecc-plan-canvas` is installed.
- **`specs/_TEMPLATE.md`** — optional `## Coordination` (Depends on / Surface) and `## Performance budget` sections; UI criteria name their Playwright check.
- **`/ps-spec`**, **`/ps-resume`**, **`dump.md`**, reference **`CLAUDE.md`** — consistency touches (renumbering updates `Depends on:` references; resumes surface parked phases; dumps invite numeric perf targets; the Capabilities template block).

### Migration from 1.x
None required. v1 projects run unchanged: specs without Coordination blocks build linearly (v1 behavior); with no providers installed, the panel's judges use their inline bars — which are v1's review bars. Add structure and providers only where they pay. Recommended after upgrading: run `/ps-doctor` once per machine, and let `/ps-start` (extend mode) or `/ps-doctor` add the `## Capabilities` map to existing projects' CLAUDE.md.
