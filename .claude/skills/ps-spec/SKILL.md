---
name: ps-spec
description: >
  pstack: add a new phase to the product, or revise/re-open an existing one. Use when
  I type /ps-spec, when I say "add a phase", "spec a new phase", "re-open phase 2", or
  "we need another phase for X". Edits ROADMAP.md and the spec files in specs/ — the
  phases are specced up front by /ps-bootstrap, so this is for changing the plan after
  the fact.
---

# Add or revise a phase

The whole product is specced at bootstrap (a ROADMAP index + one spec file per phase). Use this to change that plan: add a phase, re-scope one, or re-open a done phase.

## Steps
1. Take my intent. If it's too vague to scope, ask a couple of targeted questions with AskUserQuestion — keep it light; deep ambiguity is /ps-clarify's job.
2. Edit the docs:
   - New phase: create specs/NN-name.md from specs/_TEMPLATE.md (Goal, Requirements, Acceptance criteria checklist, Hardstop / kill, Open questions, Out of scope), and add a row to ROADMAP.md's table in the right order, with its status and whether it's in the MVP.
   - Revise / re-open: update the phase's spec file and set its status in ROADMAP.md (e.g. back to in progress).
3. If the change reveals a durable convention or a direction shift, propose a one-line update to CLAUDE.md / PRODUCT.md — but ask before editing those.
4. Hand off: /ps-clarify to close any new open items, then /ps-test for the criteria.
