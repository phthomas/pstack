---
name: ps-adopt
description: >
  pstack: adopt pstack into an EXISTING codebase. Use when I type /ps-adopt, when I'm
  adding pstack to a project that already has code, or when I say "onboard this repo",
  "retrofit pstack here", "set pstack up on my existing project", or "I want more
  clarity on this codebase". Reads my orientation dump AND surveys the code, then
  writes or augments CLAUDE.md, PRODUCT.md, and ROADMAP.md — never overwriting existing
  docs. The brownfield counterpart to /ps-bootstrap.
---

# Adopt pstack into an existing codebase

Same clarity-first front-end as a new project (`dump.md` -> /ps-dump-check -> /ps-sharpen); this is the step that turns the sharpened dump into docs when the project already has code. The code is the source of truth for WHAT exists; my sharpened dump supplies the WHY, where to focus, and the forward intent. The goal: make the implicit explicit — turn how the code already works into legible docs — and set up the forward work. Clarity of thought up front, then execution.

## Steps
1. Read sharpened_dump.md — my sharpened orientation: where to look, what to ignore, why the code exists, and what I want next. If it doesn't exist, or it's thin on the existing-codebase orientation, run /ps-dump-check then /ps-sharpen first (the same front-end as a new project). The context is the starting point, not an afterthought.
2. Confirm there's a codebase to adopt, then survey it — the survey always happens, and the code is the primary source of truth. If the repo is empty or contains only pstack's scaffold and templates (no real application or library code), this is a new project, not a brownfield one — STOP and tell me to use /ps-bootstrap instead; only proceed if I confirm there's real code to read. Otherwise, guided by the dump, read the directory structure, the build/config files (package.json, pyproject.toml, go.mod, etc.), the main entry points, the key module boundaries, the existing tests, and any README or docs. Focus where the dump points; skip what it says to ignore. Read the shape, not every line.
3. Write or augment the durable docs — and NEVER silently overwrite an existing one. For each of CLAUDE.md, PRODUCT.md, ROADMAP.md:
   - If it already exists: read it, keep what's there, and augment/reconcile — fill gaps, add what the survey reveals, and where the doc and the code disagree, flag it for me rather than clobbering. Show me the changes before writing.
   - If it doesn't exist: create it.
   What each should end up holding:
   - CLAUDE.md <- the stack, test framework, architecture, and the conventions the code actually follows (naming, error handling, structure). The main clarity win: the implicit rules, written down.
   - PRODUCT.md <- the product's purpose and direction. Code shows what, not why — take the why from my dump (ask if it's still unclear).
   - ROADMAP.md <- the index, in two parts: a short "Current state" note (or a phase or two marked done) for what already exists, and the forward phases I want from the dump, each a row pointing to a spec file in specs/. Spec the forward phases (Goal, Requirements, Acceptance criteria, Hardstop), leaving [OPEN: ...] markers where undecided. Do NOT retro-spec the existing code phase by phase — capturing it in CLAUDE.md's architecture section is enough.
4. Optionally seed docs/adr/ with one or two ADRs for the big architectural choices already baked into the code, so future decisions have context. Keep it light.
5. Note the current test status and how to run the suite, so future builds have a baseline.
6. Hand off: /ps-clarify to close the open questions on the forward phases, then /ps-test and a build gear. For just-make-it-legible adoption with no new work yet, stop once the docs are confirmed.
