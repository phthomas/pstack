---
name: ps-groom
description: >
  pstack: review and tidy the project's context docs. Use when I type /ps-groom or
  ask to clean up, prune, or tidy CLAUDE.md or the docs, or when CLAUDE.md is getting
  long. Flags bloat and misplaced content and proposes what to move where — but does
  not apply changes until I confirm.
---

# Groom the project docs

Goal: keep CLAUDE.md lean (readable in one sitting, ~a page) and every note in the file that changes at its speed.

## Steps
1. Read CLAUDE.md, and skim PRODUCT.md, ROADMAP.md, the active spec in specs/, and STATE.md for overlap.
2. Go through CLAUDE.md line by line and classify each item by how often it changes:
   - The current phase's detail (this phase, current task) -> propose moving to the phase spec in specs/.
   - Per-session status (where we are, next steps) -> propose moving to STATE.md.
   - Durable product vision / roadmap -> propose moving to PRODUCT.md.
   - Stable conventions / architecture -> keep in CLAUDE.md.
3. Also flag: stale lines, duplicates, contradictions, and anything that reads like a change log.
4. Present a proposal as a short list — keep / move-to-X / cut — with the moved text shown.
5. Wait for my confirmation. Only then apply the edits across the files.

Never silently rewrite CLAUDE.md — always show the proposal first.
