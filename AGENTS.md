# AGENTS.md

> Codex (and other `AGENTS.md`-aware agents) auto-load this file. pstack keeps its real conventions in **[CLAUDE.md](./CLAUDE.md)** — a filename Claude Code requires, which pstack reuses as the single source of truth across agents. **Read CLAUDE.md**; this file only bridges Codex to it.

## Session start
Before doing any work in a new session, run `/ps-resume` — it reads ROADMAP.md, the active phase's spec, STATE.md, and git, checks the tests, and briefs you on where things stand and the next action. Then continue from the briefing's next action. If the active phase's spec still has `[OPEN: ...]` markers, close them with `/ps-clarify` before writing any code.

## Conventions
All of [CLAUDE.md](./CLAUDE.md) applies here: architecture, the conventions (readability over cleverness; small, single-purpose functions; one phase = one branch = one PR), the always/never rules, and the decisions-and-pushback policy. Read it.

## Skills & workflow
The `ps-*` skills live in `.agents/skills/` (Codex) and `.claude/skills/` (Claude Code) — the same `SKILL.md` files, kept in sync via `scripts/sync-skills.sh`. See [PSTACK.md](./PSTACK.md) for the activity map: which skill to run when.
