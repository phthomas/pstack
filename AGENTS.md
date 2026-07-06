# AGENTS.md

> Codex, oh-my-pi, and other `AGENTS.md`-aware agents auto-load this file. pstack keeps its real conventions in **[CLAUDE.md](./CLAUDE.md)** — a filename Claude Code requires, which pstack reuses as the single source of truth across agents. **Read CLAUDE.md**; this file only bridges Codex to it.

## Session start
Before doing any work in a new session, run `/ps-resume` — it reads ROADMAP.md, the active phase's spec, STATE.md, and git, checks the tests, and briefs you on where things stand and the next action. Then continue from the briefing's next action. `[OPEN: ...]` markers in the active spec are fine — `/ps-build` and `/ps-dormammu` raise them before writing any code; answer them when asked.

## Conventions
All of [CLAUDE.md](./CLAUDE.md) applies here: architecture, conventions, the always/never rules, and the decisions-and-pushback policy. Read it.

## Skills & workflow
The `ps-*` skills live in `.agents/skills/` (Codex) and `.claude/skills/` (Claude Code) — the same `SKILL.md` files, kept in sync via `scripts/sync-skills.sh`. See [PSTACK.md](./PSTACK.md) for the activity map: which skill to run when.
