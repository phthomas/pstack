---
name: ps-resume
description: >
  pstack: get back up to speed on a pstack project at the start of a session.
  Use when I type /ps-resume, when I open a new session on an existing project,
  or when I say "catch me up", "where were we", "what's the state", or "let's
  continue". Reads ROADMAP.md, the active spec, STATE.md, and git, checks the
  tests, and gives me a short briefing plus the next action before any building
  starts.
---

# Resume — rehydrate context for a new session

The bookend to /ps-checkpoint: checkpoint saves the handoff at the end of a session, this loads it at the start of the next one. Run it before continuing work so we build from reality, not assumptions.

## Steps
1. Read ROADMAP.md — the phases and their statuses (done / in progress / planned). Find where we are.
2. Open the in-progress phase's spec in specs/ (or the next planned one) — its requirements, which acceptance criteria are ticked vs still open or failing, the hardstop, and any [OPEN: ...] markers.
3. Read STATE.md — the last session's handoff and its "Next steps".
4. Check git — `git status`, the current branch, `git log --oneline -15`, and `git worktree list` plus branches matching `ps/*` — what actually changed, whether there's uncommitted work, and whether other runs are mid-flight in sibling worktrees.
5. Check the tests — run them (or read the last known result) to see what's green and what's red right now.
6. Brief me — short, not a file dump: where we are (which phase, what's done, what's failing), what changed last session, any other runs live right now (their branch, scope, and claimed surfaces — and which of our phases they block), any open questions or blockers (including phases the last dormammu run parked, from its report), and the single most sensible next action. STATE.md is a claim; git and the tests are the facts — if they disagree, say so and trust the facts. Then stop and wait for me to confirm or redirect — don't start building on your own.

Hand off from there to /ps-build, /ps-dormammu, or /ps-spec as the next action calls for.
