# pstack

> An opinionated agent workflow for turning a brain dump into a shipped product.

pstack is a set of eight [Claude Code](https://docs.claude.com/en/docs/claude-code) skills (all prefixed `ps-`) plus a few document templates — and because they use the shared `SKILL.md` format, they run on [Codex](https://developers.openai.com/codex), [pi](https://pi.dev), and [oh-my-pi](https://omp.sh) too. It wraps one workflow: **get the product clear, then build it** — by hand a piece at a time, or unattended end to end while you sleep. Point it at a blank slate, a codebase that already exists, or a live pstack project you're feeding new ideas — the same front door fits all three.

It exists because the bottleneck in building with an AI agent usually isn't the coding — the agent can code. It's the ambiguity between *"I have an idea"* and *"the agent knows exactly what to build."* pstack is machinery for collapsing that ambiguity, starting from the messiest possible input: a brain dump.

Want the reasoning? Read [WHY.md](./WHY.md). Just want to use it? Keep going.

## Is this for you?

It fits if you:
- use Claude Code, Codex, pi, or oh-my-pi,
- have more ideas than time, and think by dumping them out rather than writing clean specs,
- are happy to adopt an opinionated workflow instead of assembling your own.

It's probably *not* for you if you want a neutral, unopinionated framework, or you're on an agent that doesn't read `SKILL.md` (today: Claude Code, Codex, pi, oh-my-pi). This is my workflow, shared — not a product.

## The idea in 30 seconds

- **Structure beats prompt-cleverness.** An agent told to "just build it" wanders; an agent given a checkable contract doesn't. The leverage is the structure around the tool.
- **Every fact lives where it changes at its own speed.** Vision (slow) -> product map -> per-phase spec -> session state (fast). One fact, one place, at its own layer — so you never have to hold the whole plan in your head.
- **"Done" is executable.** Acceptance criteria become tests — written red by the build skills before any code; decisions become append-only ADRs. Nothing important lives only in your head or the chat scrollback.
- **Clarification is a behavior, not a stage.** Questions get asked at the moment they're cheapest to answer — while drafting the specs, at a phase's start, at an autonomous run's pre-flight — never as a pipeline step you have to remember.
- **Autonomy is a dial, not a switch.** Hands-on (`/ps-build`) or unattended (`/ps-dormammu`) — one phase, the MVP, or the whole map — with hardstops so it can't run off a cliff.

## Install

pstack is really just the eight `ps-` skills plus a workflow; the same `SKILL.md` files serve all four agents.

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

**pi** — reads the same tree Codex does: `.agents/skills/` in the project, or `~/.agents/skills/` globally. The Codex copy above covers it; no extra step.

**oh-my-pi (omp)** — inherits skills, rules, and `AGENTS.md` straight from `.claude/` and `.agents/` on first run. Install for either agent above and omp picks them up.

> Each skill sits at `<tree>/skills/<name>/SKILL.md` — not double-nested. The two trees hold identical `SKILL.md` files: `.claude/skills/` is canonical, and `scripts/sync-skills.sh` regenerates `.agents/skills/` from it.

The document templates in this repo (`PRODUCT.md`, `CLAUDE.md`, `ROADMAP.md`, `specs/_TEMPLATE.md`, `STATE.md`, …) show the artifacts the workflow maintains — you don't copy them in by hand; `/ps-start` writes the docs into your project from your dump, and `/ps-checkpoint` keeps `STATE.md` current. The one file you start with is your own `dump.md`.

## The workflow

**Braindump, then one command:**

Write `dump.md` first — three loose headings (what & why, what done looks like, what's already known), messy on purpose. Dictating it is faster than typing, and everything downstream is capped by what you say — so say a lot, badly.

```
/ps-start    gates the dump, interviews you on the gaps, then writes
             PRODUCT.md, CLAUDE.md, ROADMAP.md, and one spec per phase
```

The same command covers all three situations — it detects which one it's in:
- **New project** — specs the whole product from your dump.
- **Existing codebase** — surveys the code *first*, then asks only what the code can't answer (the why, the forward intent); writes or augments the docs, never overwriting.
- **Live pstack project, new ideas** — extends the plan: appends phases, leaves the rest alone.

Details still undecided become `[OPEN: ...]` markers in the specs — deliberately. The build skills raise each one when the phase that needs it starts, so you decide at the last responsible moment, knowing the most.

**Build — pick your autonomy:**

| Gear | Command | When |
|------|---------|------|
| Hands-on | `/ps-build` | you steer piece by piece; red tests shown before any code |
| Autonomous | `/ps-dormammu [mvp \| N \| N-M] [context]` | a phase, the MVP, or everything — overnight |

Both gears write the tests themselves from each phase's acceptance criteria — there is no separate test step. `/ps-dormammu` opens with a pre-flight (one batched round of questions while you're still at the keyboard), then runs unattended: per phase, tests red -> build green -> QA -> fresh-context review -> commit, on a branch, never merging.

Both stop at `/ps-close` — verify the criteria against the tests, review the diff for completeness and simplicity, record ADRs, checkpoint, merge. **Shipping is always your call.**

**Every session:** `/ps-resume` to load (docs + git + tests -> a briefing and the next action), `/ps-checkpoint` to save the handoff.

**Change the plan:** just say it — "re-open phase 2", "this isn't working", "add a phase for X" — and `/ps-spec` catches it. A pile of new ideas? Dump again and re-run `/ps-start`.

Full activity map: [PSTACK.md](./PSTACK.md). Worked example, dump to build: [EXAMPLE.md](./EXAMPLE.md).

## The artifacts

- `dump.md` — the braindump inbox: new project, adopted codebase, or new ideas. Scratch — overwrite freely.
- `PRODUCT.md` — the vision (why). `CLAUDE.md` — how you build (conventions, auto-loaded each session).
- `ROADMAP.md` — the product map: every phase, its status, a link to its spec.
- `specs/NN-*.md` — one contract per phase: requirements, acceptance-criteria checklist, hardstop. `[OPEN: ...]` markers welcome until the phase builds.
- `STATE.md` — where you are, next steps (the session handoff).
- `docs/adr/` — architectural decisions, append-only. `tests/` — the executable definition of done. `BACKLOG.md` — parked tangents.

## Status, plainly

This is my personal, opinionated workflow, released as-is. **Fork it, crib it, rip out the Marvel names (`dormammu` is just "build it autonomously"), bend it to your stack.**

- **No maintenance promise.** Issues and PRs may sit unanswered. I change it when *my* projects need it changed.
- **It rides the agents' skill mechanisms, which move.** The `SKILL.md` format is shared across these agents today, but they all still change; it may break when they do. If it does, fork and fix.
- The defaults and taste are mine. That's the point of an opinionated tool — and the first thing you should override.

Built in the spirit of the Claude Code workflow toolkits that came before it (gstack, oh-my-claudecode, and others). This is my take.

## License

MIT — see [LICENSE](./LICENSE). Do what you like.
