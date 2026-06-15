# EXAMPLE.md — a worked walkthrough

A start-to-finish run of pstack on a small project, so the flow is concrete. The project: a viral-complaint detector for TikTok (Python, Polars/DuckDB). Yours will differ; the shape won't.

## 1. Dump — `dump.md`
You brain-dump the whole product: the problem (catch reputational risk early), the rough phases (ingest + detect, then a dashboard, then auto-triage), the stack, and what you're unsure about. Messy is fine — later steps clean it up.

## 2. Gate + sharpen — `/ps-dump-check` then `/ps-sharpen`
```
> /ps-dump-check
→ Ready, with gaps: no success metric for "viral", no data source confirmed.
> /ps-sharpen
→ Interview: which signals define viral? what's the alerting target? -> sharpened_dump.md
```

## 3. Bootstrap — `/ps-bootstrap`
```
> /ps-bootstrap
→ Wrote:
  PRODUCT.md   — vision: early warning for reputational risk on TikTok.
  CLAUDE.md    — stack (Polars/DuckDB/on-prem), conventions, readability-first.
  ROADMAP.md   — index: P1 detector + alert (MVP) · P2 dashboard · P3 auto-triage.
  specs/01-detector.md, 02-dashboard.md, 03-triage.md
               — one contract per phase: goal, requirements, criteria, hardstop.
                 A few [OPEN:] markers remain.
```
The whole product is specced — the map in ROADMAP, a contract per phase in specs/.

> **Already have a codebase?** Steps 1–2 are the same (a `dump.md` that *orients* — where to look, what to ignore, why it exists, what's next — then gate + sharpen). At this step, run `/ps-adopt` instead of `/ps-bootstrap`: it surveys the existing code and **writes or augments** the same docs — `CLAUDE.md` captures the stack and the conventions the code already follows; `ROADMAP.md` gets a short "current state" note plus the forward phases you want — reconciling with anything already there rather than overwriting. Then rejoin at step 4. Everything downstream is identical.

## 4. Clarify ALL phases — `/ps-clarify`
```
> /ps-clarify
→ Swept every spec. Closed: viral = top 5% engagement velocity over 6h (01);
  dashboard refresh = 5 min (02); auto-triage routes to the on-call queue (03).
  No [OPEN:] markers left.
```
This is the clarity bet: every phase is fully specced before a line is built.

## 5. Tests — `/ps-test`
```
> /ps-test
→ pytest scaffolded from the criteria; phase 1's are concrete and red.
```

## 6. Build it — pick a gear
Out of time, want the whole thing by morning:
```
> /ps-dormammu-magic
→ Whole product. Branch: feat/complaint-detector. Walking 01 -> 02 -> 03:
  build -> QA -> tests -> fresh-context review -> update status -> commit, per phase.
  Obeying each phase's hardstop. I'll leave a report.
```
Or, with an hour and a specific target, one phase, steered:
```
> /ps-dormammu-phase 2 reuse the chart components from the old dashboard; refresh every 5 min
→ Phase 2 only, on a branch, with that context. Same loop, scoped.
```
Or hands-on, piece by piece: `/ps-build`.

## 7. The morning — `/ps-resume`, then `/ps-close`
New session, cold context. Rehydrate before touching anything:
```
> /ps-resume
→ Where we are: 01 done, 02 done, 03 in progress — stopped at its hardstop (triage
  API creds). Last night's run walked all three; the fresh-context review applied 3
  simplifications and flagged one judgment call (dashboard caching) for you.
  Tests: 01 + 02 green, 03 red. Next action: deep-QA the flagged item, then /ps-close.
> /ps-close
→ Verified 01 + 02, deep-QA'd the flagged item, merged. 03 left for a fix + re-run.
```
P3 stopped cleanly at its hardstop instead of guessing. You give it the missing credential and intent, then `/ps-dormammu-phase 3` to finish it.

## What to take from this
- **All clarity up front.** `/ps-bootstrap` + `/ps-clarify` spec every phase before building, so an autonomous run isn't guessing.
- **Three gears of autonomy.** `/ps-build` (interactive), `/ps-dormammu-phase` (one steered phase), `/ps-dormammu-magic` (whole product). Same loop, your choice of reach.
- **Hardstops make autonomy safe.** A phase that can't proceed stops and reports rather than barrelling on.
- **Skills talk only through files.** Each reads and writes the shared docs (`ROADMAP.md`, `specs/`, `STATE.md`, `tests/`, git) — no hidden state. That's why you can stop, inspect, and re-run at any point, and swap any piece for your own.
- **Match the fix to the magnitude.** Small change -> `/ps-spec` -> build -> `/ps-close`. A wrong direction -> `/ps-adr` + re-spec. (See PSTACK.md.)
- **New or existing, and resumable.** The same front-end *adopts* a codebase (`/ps-adopt`) as easily as it *bootstraps* a new one (`/ps-bootstrap`), and every session starts with `/ps-resume` to rebuild context from the files — so the workflow fits wherever the code already is, and survives you closing the laptop.
