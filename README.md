# pstack

> An opinionated Claude Code workflow for turning a brain dump into a shipped product.

pstack is a set of [Claude Code](https://docs.claude.com/en/docs/claude-code) skills (all prefixed `ps-`) plus a few document templates. It wraps one workflow: **get the whole product clear up front, then build it** — by hand a piece at a time, or unattended end to end while you sleep.

It exists because the bottleneck in building with an AI agent usually isn't the coding — the agent can code. It's the ambiguity between *"I have an idea"* and *"the agent knows exactly what to build."* pstack is machinery for collapsing that ambiguity, starting from the messiest possible input: a brain dump.

Want the reasoning? Read [WHY.md](./WHY.md). Just want to use it? Keep going.

## Is this for you?

It fits if you:
- use Claude Code,
- have more ideas than time, and think by dumping them out rather than writing clean specs,
- are happy to adopt an opinionated workflow instead of assembling your own.

It's probably *not* for you if you want a neutral, unopinionated framework, or you're not on Claude Code. This is my workflow, shared — not a product.

## The idea in 30 seconds

- **Structure beats prompt-cleverness.** An agent told to "just build it" wanders; an agent given a checkable contract doesn't. The leverage is the structure around the tool.
- **Every fact lives where it changes at its own speed.** Vision (slow) → product map → per-phase spec → session state (fast). One fact, one place, at its own layer — so you never have to hold the whole plan in your head.
- **"Done" is executable.** Acceptance criteria become tests; decisions become append-only ADRs. Nothing important lives only in your head or the chat scrollback.
- **Autonomy is a dial, not a switch.** Three gears — hands-on, one steered phase, or the whole product overnight — with hardstops so it can't run off a cliff unattended.

## Install

pstack is really just the `ps-` skills plus a workflow. Install the skills:

```bash
# into one project:
cp -r path/to/pstack/.claude/skills/ps-* your-project/.claude/skills/

# or for every project:
cp -r path/to/pstack/.claude/skills/ps-* ~/.claude/skills/
```

Restart Claude Code (skills load at startup) and run `/skills` to confirm they're registered.

> Each skill must sit at `.claude/skills/<name>/SKILL.md` — not double-nested.

The document templates in this repo (`PRODUCT.md`, `CLAUDE.md`, `ROADMAP.md`, `specs/_TEMPLATE.md`, `STATE.md`, …) show what `/ps-bootstrap` produces — you don't copy them in by hand; `/ps-bootstrap` writes them into your project from your dump. The one file you start with is your own `dump.md`.

## The workflow

**Once per project — get it clear (cold start):**

```
/ps-dump-check   gate your dump.md; it tells you what's missing
/ps-sharpen      an interview turns the dump into sharpened_dump.md
/ps-bootstrap    writes PRODUCT.md, CLAUDE.md, a ROADMAP.md index, and one spec per phase in specs/
/ps-clarify      closes the open questions across ALL phases
/ps-test         turns acceptance criteria into (red) tests
```

Write `dump.md` yourself first — a real brain dump of the whole product. Everything downstream is capped by it, and dictating it is faster than typing.

**Build it — pick a gear:**

| Gear | Command | When |
|------|---------|------|
| Hands-on | `/ps-build` | you want to steer, piece by piece |
| One phase, steered | `/ps-dormammu-phase <context>` | you've got an hour and a target |
| Whole product | `/ps-dormammu-magic` | you're out of time; build it all overnight |

All three stop at `/ps-close` — verify, review, merge. **Shipping is always your call;** the autonomous gears never merge or deploy, and they stop at a phase's hardstop rather than guessing.

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
- **It's glued to Claude Code's skill mechanism, which moves.** It may break when that changes. If it does, fork and fix.
- The defaults and taste are mine. That's the point of an opinionated tool — and the first thing you should override.

Built in the spirit of the Claude Code workflow toolkits that came before it (gstack, oh-my-claudecode, and others). This is my take.

## License

MIT — see [LICENSE](./LICENSE). Do what you like.
