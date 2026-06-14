---
name: ps-bootstrap
description: >
  pstack: turn a sharpened brain dump into the project's starting docs. Use when I
  type /ps-bootstrap, when I'm starting a brand-new project, or when I say "set this
  up", "initialize the repo", or "scaffold the docs". Reads sharpened_dump.md and
  writes PRODUCT.md, CLAUDE.md, a ROADMAP.md index, and a spec file per phase in
  specs/ — covering every phase of the product, not just the first.
---

# Bootstrap the project docs

Cold-start orchestrator. Turn sharpened_dump.md into the durable docs, with the WHOLE product specced phase by phase so it's ready to clarify and build end to end.

## Steps
1. Confirm this is a cold start: there's no existing CLAUDE.md / PRODUCT.md, or I explicitly asked. If they already exist, stop and point me to /ps-spec.
2. Read sharpened_dump.md. If it doesn't exist, run /ps-sharpen first.
3. Write the docs:
   - PRODUCT.md <- the durable vision, the problem, the direction (the why).
   - CLAUDE.md <- conventions, architecture, standing rules. Keep it lean (~a page).
   - ROADMAP.md <- the index: a "Phases at a glance" table with a row per phase (status, in-MVP, and the path to its spec file), plus the MVP boundary.
   - specs/NN-name.md <- one spec file per phase (use specs/_TEMPLATE.md as the shape). Spec EVERY phase, not just the first: Goal, Requirements, Acceptance criteria (a checklist), Hardstop / kill criteria, Out of scope. Where the brief doesn't settle something, leave an [OPEN: ...] marker rather than guessing. Number them so they sort in order (01, 02, ...).
4. Be conservative about CLAUDE.md and PRODUCT.md: when unsure whether something is durable, put it in the relevant phase's spec file, not the stable layer.
5. Show me the drafts before finalizing. Then run /ps-clarify to close the open items across all phases, and /ps-test to lay down the first tests.
