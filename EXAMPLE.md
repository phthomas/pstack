# EXAMPLE.md — a worked walkthrough

A start-to-finish run of pstack on a small project, so the flow is concrete. The project: a viral-complaint detector for TikTok (Python, Polars/DuckDB). Yours will differ; the shape won't.

## 1. Dump — `dump.md`
Five minutes of dictation under three loose headings — what & why (catch reputational risk early), what done looks like (an alert within the hour, then a dashboard, then auto-triage), what's known (Polars/DuckDB, on-prem, unsure how to define "viral"). Messy, half-ordered, honest.

## 2. One command — `/ps-start`
```
> /ps-start
→ Greenfield (no code, no docs). The dump is workable; two gaps matter now:
  what makes a complaint "viral", and where the data comes from.
  [interview: 4 questions, each with a recommended default]
→ Wrote:
  PRODUCT.md   — early warning for reputational risk on TikTok.
  CLAUDE.md    — Python 3.12, Polars/DuckDB, pytest, on-prem; readability-first.
  AGENTS.md    — two-line bridge for Codex/pi/omp -> read CLAUDE.md.
  ROADMAP.md   — P1 detector + alert (MVP) · P2 dashboard · P3 auto-triage.
  specs/01-detector.md · 02-dashboard.md · 03-triage.md
→ 2 [OPEN:] markers left (dashboard refresh rate, triage routing) — deliberately.
  The build skills will ask when those phases start.
```
The whole product is specced: the map in ROADMAP.md, a contract per phase in specs/. Phase-1 decisions are settled; phase-2 and -3 details wait until they matter.

> **Already have a codebase?** Same command. `/ps-start` surveys the code *first*, then interviews you only on what the code can't say (the why, the forward intent, the pain points) — so the dump can be five lines. It augments any existing docs rather than overwriting, notes the test baseline, and specs only the forward phases.

## 3. Build — `/ps-dormammu`
Out of time; want the product by morning:
```
> /ps-dormammu
→ Pre-flight: 2 open items in scope.
  Dashboard refresh — recommend 5 min (cheap to change). Triage routing —
  needs your on-call setup; no safe assumption.
> 5 min is fine; route triage to the #oncall queue
→ Branch feat/complaint-detector. Walking 01 -> 02 -> 03, per phase:
  one fresh-context builder per phase: tests from criteria (red) -> build to
  green -> mechanical gate -> review panel -> commit. Hardstops obeyed.
  Report when I stop.
```
With an hour and a target instead: `/ps-dormammu 2 reuse the old chart components`. Hands-on instead: `/ps-build` — it writes the phase's tests, shows them red for your check, then implements to green, pausing for steering.

## 4. The morning — `/ps-resume`, then `/ps-close`
New session, cold context. Rehydrate before touching anything:
```
> /ps-resume
→ 01 done, 02 done, 03 stopped at its hardstop (triage API credentials).
  The panel applied 3 simplifications; 1 judgment call flagged
  (panel: correctness ✓ inline · parsimony ✓ inline · product ✓ · security — not triggered)
  (dashboard caching). Tests: 01 + 02 green, 03 red.
  Next action: deep-QA the flagged item, then /ps-close.
> /ps-close
→ Criteria verified against the tests; diff reviewed (complete + clean);
  1 must-fix applied; ADR recorded for the DuckDB choice (docs/adr/_EXAMPLE-use-duckdb-for-analytics.md); STATE.md written.
  Merged through 02's commit; 03 stays on the branch, waiting on the credential.
```
You hand over the credential, then `/ps-dormammu 3` finishes the product.

## 5. Two weeks later — new ideas
You braindump v2 thoughts (multi-platform, weekly digest) into `dump.md` over the old contents and run `/ps-start` again:
```
> /ps-start
→ Extend mode (live pstack project). Interviewing on the delta only...
→ Appended P4 multi-platform · P5 weekly digest (specs/04, 05).
  PRODUCT.md untouched — the direction didn't move.
```
Then `/ps-dormammu 4-5` overnight, or `/ps-build` by hand. A change that fits in a sentence skips the dump entirely: "re-open phase 2, the dashboard needs auth" — `/ps-spec` catches it.

## What to take from this
- **One front door.** New repo, existing code, or a live project — `dump.md` + `/ps-start`, and it detects which.
- **Clarity when it pays, not all up front.** Phase-1 questions at start; phase-3 questions at phase 3 (or at dormammu's pre-flight). `[OPEN:]` markers are healthy, not debt.
- **Tests are not a step.** Every gear turns criteria into red tests before building — that's what keeps "done" checkable, attended or not.
- **Hardstops make autonomy safe.** A phase that can't proceed stops and reports instead of guessing.
- **Skills talk only through files** (ROADMAP.md, specs/, STATE.md, tests/, git) — no hidden state. That's why you can stop, inspect, and re-run at any point, and swap any piece for your own.
- **Shipping is always yours.** The autonomous gear never merges; `/ps-close` is the human gate.
