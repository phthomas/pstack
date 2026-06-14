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

## 7. The morning — review and `/ps-close`
```
ROADMAP.md   — 01 done, 02 done, 03 in progress (stopped: triage API creds needed).
Report       — 01/02 criteria green; review applied 3 simplifications; flagged 1
               judgment call (dashboard caching) for you. 03 hit its hardstop.
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
