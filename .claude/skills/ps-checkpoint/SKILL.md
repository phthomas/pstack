---
name: ps-checkpoint
description: >
  pstack: overwrite STATE.md with the current handoff state so the next session can
  resume cleanly. Use this at the end of a working session, before I stop, or
  whenever I type /ps-checkpoint or say things like "save progress", "where were
  we", or "wrap up for now" — even if I don't mention STATE.md.
---

# Update the session handoff (STATE.md)

## Steps
1. Review what changed this session: run `git status` and `git diff --stat`, and skim what we did in the conversation.
2. OVERWRITE STATE.md (do not append) using the structure below.
3. Keep it to a screenful — only current state, in-flight work, next steps, and blockers.
4. Do NOT write a change log (the git diff is the record) and do NOT restate the product vision (that's PRODUCT.md / CLAUDE.md).
5. Set "Last updated" to today and "Branch" to the current branch.

## Structure
- `Last updated: <date> · Branch: <branch>`
- `## Current state` — what's done and working now.
- `## In flight` — partially done, mid-change.
- `## Next steps` — the immediate next actions, ordered; the next session starts here.
- `## Blockers / open issues` — anything stuck, risky, or waiting.
