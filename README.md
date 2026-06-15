# pstack

> An opinionated Claude Code & Codex workflow for turning a brain dump into a shipped product.

pstack is a set of [Claude Code](https://docs.claude.com/en/docs/claude-code) skills (all prefixed `ps-`) plus a few document templates — and because they use the shared `SKILL.md` format, they run on [Codex](https://developers.openai.com/codex) too. It wraps one workflow: **get the whole product clear up front, then build it** — by hand a piece at a time, or unattended end to end while you sleep. Point it at a blank slate or a codebase that already exists — the same clarity-first front-end fits both.

It exists because the bottleneck in building with an AI agent usually isn't the coding — the agent can code. It's the ambiguity between *"I have an idea"* and *"the agent knows exactly what to build."* pstack is machinery for collapsing that ambiguity, starting from the messiest possible input: a brain dump.

Want the reasoning? Read [WHY.md](./WHY.md). Just want to use it? Keep going.

## Is this for you?

It fits if you:
- use Claude Code or Codex,
- have more ideas than time, and think by dumping them out rather than writing clean specs,
- are happy to adopt an opinionated workflow instead of assembling your own.

It's probably *not* for you if you want a neutral, unopinionated framework, or you're on an agent that doesn't read `SKILL.md` (today that's Claude Code and Codex). This is my workflow, shared — not a product.

## The idea in 30 seconds

- **Structure beats prompt-cleverness.** An agent told to "just build it" wanders; an agent given a checkable contract doesn't. The leverage is the structure around the tool.
- **Every fact lives where it changes at its own speed.** Vision (slow) → product map → per-phase spec → session state (fast). One fact, one place, at its own layer — so you never have to hold the whole plan in your head.
- **"Done" is executable.** Acceptance criteria become tests; decisions become append-only ADRs. Nothing important lives only in your head or the chat scrollback.
- **Autonomy is a dial, not a switch.** Three gears — hands-on, one steered phase, or the whole product overnight — with hardstops so it can't run off a cliff unattended.

## Install

pstack is really just the `ps-` skills plus a workflow — and they use the shared `SKILL.md` format, so they run on **Claude Code** and **Codex** alike.

**Claude Code** — skills live in `.claude/skills/`:

```bash
cp -r path/to/pstack/.claude/skills/ps-* your-project/.claude/skills/   # one project
cp -r path/to/pstack/.claude/skills/ps-* ~/.claude/skills/              # every project
```

Restart Claude Code (skills load at startup) and run `/skills` to confirm they're registered.

**Codex** — skills live in `.agents/skills/`, and Codex auto-loads `AGENTS.md` (pstack's `AGENTS.md` bridges to `CLAUDE.md`):

```bash
cp -r path/to/pstack/.agents/skills/ps-* your-project/.agents/skills/   # one project
cp -r path/to/pstack/.agents/skills/ps-* ~/.agents/skills/             # every user
```

Restart Codex; the skills trigger by description or as slash commands. (Codex skill paths have shifted across versions — if `.agents/skills` isn't picked up, check your version's docs, e.g. `~/.codex/skills`.)

> Each skill sits at `<tree>/skills/<name>/SKILL.md` — not double-nested. The two trees hold identical `SKILL.md` files: `.claude/skills/` is canonical, and `scripts/sync-skills.sh` regenerates `.agents/skills/` from it.

The document templates in this repo (`PRODUCT.md`, `CLAUDE.md`, `ROADMAP.md`, `specs/_TEMPLATE.md`, `STATE.md`, …) show what `/ps-bootstrap` produces — you don't copy them in by hand; `/ps-bootstrap` writes them into your project from your dump. The one file you start with is your own `dump.md`.

## The workflow

**Once per project — get it clear (cold start):**

```
/ps-dump-check   gate your dump.md; it tells you what's missing
/ps-sharpen      an interview turns the dump into sharpened_dump.md
/ps-bootstrap    new project: writes PRODUCT.md, CLAUDE.md, a ROADMAP.md index, and one spec per phase
/ps-clarify      closes the open questions across ALL phases
/ps-test         turns acceptance criteria into (red) tests
```

Write `dump.md` yourself first — a real brain dump of the whole product. Everything downstream is capped by it, and dictating it is faster than typing.

**Already have a codebase?** Same front-end — write `dump.md` (the orientation kind: where to look, what to ignore, why, what's next), then `/ps-dump-check` and `/ps-sharpen` — then run `/ps-adopt` instead of `/ps-bootstrap`. It surveys your code guided by the sharpened dump and writes or augments `CLAUDE.md`, `PRODUCT.md`, and `ROADMAP.md`, reconciling with any existing docs rather than overwriting them. Continue from `/ps-clarify`.

**Build it — pick a gear:**

| Gear | Command | When |
|------|---------|------|
| Hands-on | `/ps-build` | you want to steer, piece by piece |
| One phase, steered | `/ps-dormammu-phase <context>` | you've got an hour and a target |
| Whole product | `/ps-dormammu-magic` | you're out of time; build it all overnight |

All three stop at `/ps-close` — verify, review, merge. **Shipping is always your call;** the autonomous gears never merge or deploy, and they stop at a phase's hardstop rather than guessing.

**Every new session,** run `/ps-resume` first — it rehydrates context (docs, git, tests) and tells you where you left off and what's next.

Full activity map: [PSTACK.md](./PSTACK.md). Worked example, dump to build: [EXAMPLE.md](./EXAMPLE.md).

## The artifacts

- `PRODUCT.md` — the vision (why). `CLAUDE.md` — how you build (conventions, auto-loaded each session).
- `ROADMAP.md` — the product map: every phase, its status, a link to its spec.
- `specs/NN-*.md` — one contract per phase: requirements, acceptance-criteria checklist, hardstop.
- `STATE.md` — where you are, next steps (the session handoff).
- `docs/adr/` — architectural decisions, append-only. `tests/` — the executable definition of done. `BACKLOG.md` — parked tangents.
- `dump.md` / `sharpened_dump.md` — cold-start scratch.

## Status, plainly

This is my personal, opinionated workflow, released as-is. **Fork it, crib it, rip out the Marvel names (`dormammu` is just "build it autonomously"), bend it to your stack.**

- **No maintenance promise.** Issues and PRs may sit unanswered. I change it when *my* projects need it changed.
- **It rides the agents' skill mechanisms, which move.** The `SKILL.md` format is shared by Claude Code and Codex now, but both still change; it may break when they do. If it does, fork and fix.
- The defaults and taste are mine. That's the point of an opinionated tool — and the first thing you should override.

Built in the spirit of the Claude Code workflow toolkits that came before it (gstack, oh-my-claudecode, and others). This is my take.

## License

MIT — see [LICENSE](./LICENSE). Do what you like.
