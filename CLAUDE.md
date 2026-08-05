# CLAUDE.md

> Stable project context, auto-loaded every session. Keep this readable in one sitting (~a page). If it grows past that, prune it: a phase's detail belongs in its spec file under specs/, current status in STATE.md, the product vision in PRODUCT.md.

## Session start
Before doing any work in a new session, run `/ps-resume` — it reads ROADMAP.md, the active phase's spec, STATE.md, and git, checks the tests, and briefs you on where things stand and the next action. (By hand, if you prefer: read ROADMAP.md and the in-progress phase's spec in specs/, read STATE.md, then `git log --oneline -10` and `git status`.)

Then continue from the briefing's next action. `[OPEN: ...]` markers in the active spec are fine — `/ps-build` and `/ps-dormammu` raise them before writing any code; answer them when asked.

## What we're building
<!-- One line only. The full overview lives in PRODUCT.md — don't duplicate it here. -->

## Architecture
<!-- The durable shape of the system. Edit to match your project. -->
- Stack / language: <!-- e.g. Python 3.12; or Go; or TypeScript/Node; or Rust -->
- Test framework: <!-- e.g. pytest; go test; vitest; cargo test — the build skills write tests in this -->
- Data / key libraries: <!-- e.g. Polars + DuckDB on Parquet; or your equivalent -->
- Key modules and their boundaries: <!-- the few that matter -->

## Conventions
<!-- How we build here. Keep the universal ones; replace the stack-specific line with yours. -->
- Optimize for readability over cleverness: the simplest solution that works wins, and less code beats more.
- Keep functions small and single-purpose; prefer explicit code over heavy framework magic.
- One phase = one branch = one PR; a multi-phase `/ps-dormammu` run rides one run branch, committed per phase. Acceptance criteria become tests — the build skills write them, red first.
- Stack-specific conventions go here — e.g. Python: prefer Polars over pandas, type hints on public functions; Go: idiomatic error handling, no needless interfaces; etc.

## Capabilities
<!-- Capability -> provider -> fallback. The one place providers are named: /ps-review, /ps-build, and /ps-dormammu resolve against this and degrade gracefully — never silently. /ps-start writes it from a probe of the real environment; /ps-doctor re-syncs it. Edit to match yours. -->
- correctness-review: <!-- e.g. ecc python-reviewer + fastapi-reviewer --> | fallback: inline bar (ps-review)
- parsimony-review: <!-- e.g. ponytail-review --> | fallback: inline bar (ps-review)
- product-review: built-in (ps-review) — no provider exists; this one is ours
- docs: installed source (venv / node_modules, version-exact) -> official docs via websearch + webfetch <!-- optional: a docs CLI as convenience --> | fallback: training knowledge, flag unverified calls
- browser: <!-- e.g. chrome-devtools MCP (frontend projects only) --> | fallback: Playwright artifacts
- gate: <!-- e.g. ruff · pyright --strict · pytest (+pytest-benchmark, hypothesis) -->
- canvas: <!-- ecc-plan-canvas if installed --> | fallback: typed confirm
- craft: <!-- model-invocable moves for builders, e.g. prototype, diagnosing-bugs, resolving-merge-conflicts, domain-modeling, research (mattpocock/skills subset) --> | fallback: none — [OPEN-SPIKE: ...] markers degrade to ordinary [OPEN: ...]
- model-tiers: deep = session model · standard = <!-- e.g. sonnet --> · mechanical = <!-- e.g. sonnet --> | fallback: everything on the session model
  <!-- Tiers map task nature -> model, never role -> model: deep = design, judging, prose craft, security; standard = routine building
       against a clear spec; mechanical = applying known fixes, recounts, delta re-checks. Default standard AND mechanical to the rung
       one below the session model — small models flail on real edits; mechanical differs in discipline and effort (where a per-spawn
       effort knob exists: deep inherits the session's, mechanical runs low), not necessarily model. A failed agent retries once on the
       next DISTINCT tier up; the gate re-runs after mechanical work regardless. Only meaningful where the harness sets models per spawn. -->

<!-- Standing rule that adapts borrowed craft skills to pstack's files-as-truth (they may default to an issue tracker):
     prototype captures land in pstack artifacts — the verdict resolves the spec's open question, the throwaway-branch
     pointer goes in the spec, and an architectural verdict gets an ADR. Adaptations live here, never in provider files. -->

## Always / never
- Always write a regression test for every bug you fix.
- Always record significant or architectural decisions with `/ps-adr`.
- Never re-narrate changes in prose — the git diff and commit messages are the change record.
- Never edit a past ADR's content; supersede it with a new one.

## Decisions and pushback
When I assert a technical decision, evaluate it against security, safety, correctness, and maintainability before accepting it.
- If it's sound, or low-stakes and reversible, proceed without ceremony.
- If it's materially risky, insecure, or will cause real problems, push back ONCE: name the specific risk and offer a better option. Don't hedge with "are you sure?", and don't bikeshed style or preference.
- If I acknowledge the risk and choose to proceed, respect it and move on.
- Weight scrutiny by stakes: scrutinize anything irreversible or touching security, data, or money; let low-stakes calls pass fast.

## How these docs work
See PSTACK.md for the activity map and which skill to run when.

Route any note by how often it changes:
- Slow (conventions, architecture, vision) -> CLAUDE.md or PRODUCT.md
- The product map — phases, status, links to specs -> ROADMAP.md
- A phase's contract — requirements, acceptance criteria, hardstop -> specs/<phase>.md
- Per-session (where we are, next steps) -> STATE.md
- Decisions and their rationale -> docs/adr/ (append-only)
- A braindump — new project, adopted codebase, or new ideas for a live one -> dump.md, then /ps-start
