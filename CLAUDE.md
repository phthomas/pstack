# CLAUDE.md

> Stable project context, auto-loaded every session. Keep this readable in one sitting (~a page). If it grows past that, run `/ps-groom`: a phase's detail belongs in its spec file under specs/, current status in STATE.md, the product vision in PRODUCT.md.

## Session start
Before doing any work in a new session:
1. Read ROADMAP.md — the phase index and statuses. Find the phase that's in progress (or the next planned one), then open its spec file in specs/ for the requirements, acceptance criteria, and hardstop.
2. Read STATE.md — where the last session left off and the next steps.
3. Run `git log --oneline -10` and `git status` to see what actually changed.

Then continue from STATE.md's "Next steps". If that phase's spec file still has `[OPEN: ...]` markers, close them with `/ps-clarify` before writing any code.

## What we're building
<!-- One line only. The full overview lives in PRODUCT.md — don't duplicate it here. -->

## Architecture
<!-- The durable shape of the system. Edit to match your project. -->
- Stack / language: <!-- e.g. Python 3.12; or Go; or TypeScript/Node; or Rust -->
- Test framework: <!-- e.g. pytest; go test; vitest; cargo test — /ps-test writes tests in this -->
- Data / key libraries: <!-- e.g. Polars + DuckDB on Parquet; or your equivalent -->
- Key modules and their boundaries: <!-- the few that matter -->

## Conventions
<!-- How we build here. Keep the universal ones; replace the stack-specific line with yours. -->
- Optimize for readability over cleverness: the simplest solution that works wins, and less code beats more.
- Keep functions small and single-purpose; prefer explicit code over heavy framework magic.
- One phase = one branch = one PR. Acceptance criteria become tests.
- Stack-specific conventions go here — e.g. Python: prefer Polars over pandas, type hints on public functions; Go: idiomatic error handling, no needless interfaces; etc.

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
- Initialization scratch (raw + sharpened brief) -> dump.md / sharpened_dump.md
