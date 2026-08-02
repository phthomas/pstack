---
name: ps-init
description: >
  pstack: audit and realign the project docs with reality. Use when I type
  /ps-init, right after installing pstack into a repo, or when I say "align
  the docs", "are the docs still accurate", "the docs drifted", "sanity-check
  the ADRs", "does STATE.md match the code" — or after work happened outside
  the skills (manual commits, another agent, a big refactor). Detects whether
  this is a greenfield repo, a brownfield codebase, or a live pstack project,
  checks every pstack artifact — CLAUDE.md, PRODUCT.md, ROADMAP.md, specs/,
  STATE.md, docs/adr/, CONTEXT.md — against the codebase, git history, and
  tests, reports the drift, and fixes it with my sign-off. Repairs only —
  a missing doc set is /ps-start's job to create.
---

# Init — align the docs with the code

The docs are pstack's memory; every other skill trusts them. This skill earns that trust back after anything happened outside the workflow: work committed by hand, another agent, a refactor, a long gap. It never invents — where reality and a doc disagree, reality wins and the doc gets corrected, visibly.

## Step 1 — detect the situation
Survey the tree and git before touching any doc:
- **Greenfield** (no meaningful code yet): the docs describe intent, not history — check only their internal consistency (ROADMAP rows ↔ spec files, CLAUDE.md stack ↔ scaffolding choices) and stop; there is no reality to drift from yet.
- **Brownfield, no pstack docs** (code exists, no PRODUCT.md/ROADMAP.md): nothing to align. Say so and hand off to /ps-start, which onboards by surveying the code first. Do not scaffold docs here.
- **Live pstack project** (code and docs both exist): run the full audit below. If `git worktree list` or `ps/*` branches show a live run, note it — ROADMAP is append-only while a run is live, and another run's claims are not drift.

## Step 2 — gather reality
The evidence base, collected once: `git log --oneline -30` and `git status`; the file tree and entry points; the test suite run (or at minimum collected); the environment probed for capabilities exactly as /ps-doctor does. Reality is code + git + tests — never a doc's claim about them.

## Step 3 — audit, artifact by artifact
For each, state what "aligned" means and check it:
- **CLAUDE.md** — stack, test framework, and key modules match what's actually in the tree; conventions aren't contradicted by the dominant style of the code; `## Capabilities` matches the probe (stale entries are drift). Standing rules reference files that exist.
- **PRODUCT.md** — the vision still describes this product. Flag contradictions; never rewrite direction on my behalf — a direction change is /ps-adr + /ps-spec territory.
- **ROADMAP.md + specs/** — every phase marked done has its acceptance criteria actually covered by passing tests; every in-progress phase shows matching recent commits; specs' ticked criteria match test reality; `Depends on:` references point at phases that exist. Unticked-but-passing and ticked-but-failing are both drift.
- **STATE.md** — its "where we are / next steps" match git and the test run. If not, it gets regenerated (Step 4), not patched line by line.
- **docs/adr/** — two-way check: decisions the code visibly reversed (ADR says X, code does Y) and significant decisions visible in the code with no ADR at all (a database, a framework, an auth scheme). ADRs are append-only — drift here is never fixed by editing; it's fixed by proposing a superseding /ps-adr.
- **CONTEXT.md** (if present) — glossary terms still match the names the code actually uses; `_Avoid_:` terms that crept into the code get flagged.
- **AGENTS.md** — the two-line bridge to CLAUDE.md exists and points at a file that exists.

## Step 4 — report, then repair with sign-off
Present one drift report: artifact — what it claims — what reality shows — proposed fix, ordered by severity. Then repair in two tiers:
- **Mechanical** (statuses, ticks, stale capability lines, STATE.md regeneration via /ps-checkpoint's structure, the AGENTS.md bridge): batch them, show the batch, apply on one confirmation.
- **Judgment** (a phase that looks done but isn't specced that way, a contradicted ADR, a PRODUCT.md tension): ask me item by item, each with a recommended fix and its tradeoff. Superseding ADRs go through /ps-adr; plan changes go through /ps-spec; never renumber phases while a run is live.

Close with the same discipline as any session: STATE.md reflecting the now-aligned state, and one summary line per artifact — aligned, repaired, or deferred-to-me.

## Boundaries
- /ps-resume briefs and trusts git over STATE.md for one session; /ps-init *repairs* the docs so the next resume has nothing to distrust.
- /ps-doctor owns the environment probe; init reuses its method and only syncs the map.
- /ps-start creates docs from a dump or a survey; init never creates the doc set — it hands a bare repo to /ps-start.
