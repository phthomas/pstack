# pstack

> An opinionated agent workflow for turning a brain dump into a shipped product.

pstack is a set of eleven [Claude Code](https://docs.claude.com/en/docs/claude-code) skills (all prefixed `ps-`) plus a few document templates — and because they use the shared `SKILL.md` format, they run on [Codex](https://developers.openai.com/codex), [OpenCode](https://opencode.ai), [pi](https://pi.dev), and [oh-my-pi](https://omp.sh) too. It wraps one workflow: **get the product clear, then build it** — by hand a piece at a time, or unattended end to end while you sleep. Point it at a blank slate, a codebase that already exists, or a live pstack project you're feeding new ideas — the same front door fits all three.

It exists because the bottleneck in building with an AI agent usually isn't the coding — the agent can code. It's the ambiguity between *"I have an idea"* and *"the agent knows exactly what to build."* pstack is machinery for collapsing that ambiguity, starting from the messiest possible input: a brain dump.

**2.x adds the other half:** once the ambiguity is collapsed, pstack also runs the *execution* well — fresh-context builders in dependency waves (parallel where the specs allow), a mechanical gate before any review, and a risk-weighted review panel of fresh-context judges (correctness, over-engineering, built-vs-specced, security — one combined judge by default, split when the diff earns it). pstack stays pure markdown; the panel's muscle comes from **capability providers** you install once and pstack detects — see [Providers](#layer-1--providers-optional-recommended) — and heavy models are spent only where judgment lives — see [Model selection](#model-selection--one-line-three-tiers).

Want the reasoning? Read [WHY.md](./WHY.md). Just want to use it? Keep going.

## Is this for you?

It fits if you:
- use Claude Code, Codex, OpenCode, pi, or oh-my-pi,
- have more ideas than time, and think by dumping them out rather than writing clean specs,
- are happy to adopt an opinionated workflow instead of assembling your own.

It's probably *not* for you if you want a neutral, unopinionated framework, or you're on an agent that doesn't read `SKILL.md` (today: Claude Code, Codex, OpenCode, pi, oh-my-pi). This is my workflow, shared — not a product.

## The idea in 30 seconds

- **Structure beats prompt-cleverness.** An agent told to "just build it" wanders; an agent given a checkable contract doesn't. The leverage is the structure around the tool.
- **Every fact lives where it changes at its own speed.** Vision (slow) -> product map -> per-phase spec -> session state (fast). One fact, one place, at its own layer — so you never have to hold the whole plan in your head.
- **"Done" is executable.** Acceptance criteria become tests — written red by the build skills before any code; performance budgets become failing benchmarks; decisions become append-only ADRs. Nothing important lives only in your head or the chat scrollback.
- **Measurement over exhortation.** "Write good code" is a wish. A strict typecheck, a benchmark budget, and an independent judge are enforcement. Wherever 2.0 could turn advice into a measurement or a fresh-context verdict, it did.
- **Capabilities live in the environment, never in the core.** pstack is markdown; reviewers, docs lookup, browser eyes, and the plan canvas are *providers* the skills detect and use — and degrade without, visibly. One `## Capabilities` map in CLAUDE.md names them; `/ps-doctor` keeps it honest.
- **Clarification is a behavior, not a stage.** Questions get asked at the moment they're cheapest to answer — while drafting the specs, at a phase's start, at an autonomous run's pre-flight — never as a pipeline step you have to remember.
- **Autonomy is a dial, not a switch.** Hands-on (`/ps-build`) or unattended (`/ps-dormammu`) — one phase, the MVP, or the whole map, sequential or in parallel waves — with hardstops so it can't run off a cliff.

## Install

Three layers. Only the first is required — everything after it is a provider pstack detects.

### Layer 0 — the skills (required)

pstack is really just the eleven `ps-` skills plus a workflow; the same `SKILL.md` files serve all five agents — every supported agent reads one of the repo's two identical trees.

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

**OpenCode** — needs no tree of its own: it reads `.claude/skills/` and `.agents/skills/` natively, at both project level and home level (`~/.claude/skills/`, `~/.agents/skills/`, or its own `~/.config/opencode/skills/`). Either copy above covers it; no extra step. pstack's `AGENTS.md` bridge gives it the project context too.

**pi** — reads the same tree Codex does: `.agents/skills/` in the project, or `~/.agents/skills/` globally. The Codex copy above covers it; no extra step.

**oh-my-pi (omp)** — inherits skills, rules, and `AGENTS.md` straight from `.claude/` and `.agents/` on first run. Install for either agent above and omp picks them up.

> Each skill sits at `<tree>/skills/<name>/SKILL.md` — not double-nested. The two trees hold identical `SKILL.md` files: `.claude/skills/` is canonical, and `scripts/sync-skills.sh` regenerates `.agents/skills/` from it.

### Layer 1 — providers (optional, recommended)

Global, one-time installs. pstack works without any of them — `/ps-review`'s judges fall back to inline bars, gates fall back to typed confirms — but each provider it finds makes a specific judge or gate stronger. Install what you'll use; `/ps-doctor` shows what resolved.

| Capability | Provider | Install (once) |
|---|---|---|
| Correctness + security review | [ECC](https://github.com/affaan-m/ECC) reviewer agents (python, fastapi, react, typescript, code, security) | `git clone https://github.com/affaan-m/ECC && cd ECC && npm install && ./install.sh --profile minimal --target claude` — the manual installer; agents land in `~/.claude/agents/`. Skip the plugin route (it can't ship rules and stacks badly). |
| Parsimony review | [Ponytail](https://github.com/DietrichGebert/ponytail) (`ponytail` + `/ponytail-review`) | `npx -y skills add DietrichGebert/ponytail` — plain skill files, no runtime. |
| Plan canvas | `ecc-plan-canvas` (annotate-in-browser review at the gates) | `npm i -g ecc-universal` — needs node; serves on `127.0.0.1:4517`. |
| Craft (builders' model-invoked moves) | [mattpocock/skills](https://github.com/mattpocock/skills) subset: `prototype`, `diagnosing-bugs`, `resolving-merge-conflicts`, `domain-modeling`, `research` | Selective install — see [Installing craft](#installing-craft-bring-only-the-subset) below. Never `npx skills add mattpocock/skills` bare: the full repo includes `tdd` and `code-review`, which collide with ps-build's loop and ps-review's panel. |

#### Installing craft: bring only the subset

2.2's one new dependency is the craft provider, and the rule is **install by name, never by repo** — the skills you don't list never land, so there's nothing to remember to remove:

```bash
npx skills add mattpocock/skills \
  --skill prototype \
  --skill diagnosing-bugs \
  --skill resolving-merge-conflicts \
  --skill domain-modeling \
  --skill research
```

- Add `-g` to install globally instead of into the current project.
- Multi-agent: add `-a claude-code -a codex -a opencode` to install the same subset for each agent's tree in one command (the CLI knows each agent's directory).
- **Deliberately excluded, don't add them:** `tdd` and `code-review` collide with ps-build's red-first loop and ps-review's fresh-context panel; `wayfinder`/`to-tickets`/`triage` assume an issue tracker as the source of truth, and pstack's truth is ROADMAP.md + specs (ADR 0005). If a later resync drags `tdd` or `code-review` back in as model-invocable, `/ps-doctor` flags it.
- Copies are frozen at install; resync upstream changes as a reviewed diff (re-run the same command and inspect). Adaptations — e.g. where prototype captures land — live in your CLAUDE.md standing rules, never in the provider files, so resyncs stay clean.
- Installing nothing is fine: without the craft capability, `[OPEN-SPIKE: ...]` markers degrade to ordinary `[OPEN: ...]` questions, visibly.

### Layer 2 — per project

- **Docs grounding** needs no MCP — the ladder is built into the build skills: read the *installed source* first (the package in the project's venv or `node_modules` is version-exact by construction and can't be poisoned by a registry), then official docs via the harness's own websearch + webfetch. A docs CLI ([context7](https://github.com/upstash/context7)'s, for instance) is optional convenience for one-off lookups, never load-bearing — see ADR 0003.
- **Browser** (the product judge's eyes on UI phases): add [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) to the project's `.mcp.json` — only where there's a frontend; its tool schemas cost context, so don't carry them in backend repos:

```json
{ "mcpServers": {
    "chrome-devtools": { "command": "npx", "args": ["-y", "chrome-devtools-mcp@latest"] }
} }
```

- **The gate** — the tools the build skills loop against, in the project's dev deps. Python: `uv add --dev ruff pyright pytest pytest-benchmark hypothesis`. UI phases: `uv add --dev pytest-playwright && playwright install chromium` (or the TS equivalents: formatter, `tsc`, test runner, Playwright).

Then run `/ps-doctor`: it prints the manifest (capability — provider — gap + install hint) and writes the `## Capabilities` map into CLAUDE.md so every skill resolves providers from one place.

### Model selection — one line, three tiers

Where the harness can pick a model per spawned agent (Claude Code's Task tool can; OpenCode's per-agent config can; a plain Codex session can't), the Capabilities map carries one more line, and the build skills route every spawn through it:

```markdown
- model-tiers: deep = session model · standard = sonnet · mechanical = sonnet | fallback: everything on the session model
```

Tiers map **task nature -> model, never role -> model** — a "judge" can be forensic or a formality, a "builder" can be designing or transcribing, so roles are the wrong key:

- **deep** — design judgment, independent verdicts, prose craft, anything security-touched. Anchored to the *session model* on purpose: whatever you launched with is the ceiling, the map only ever downgrades below it, and it can't go stale as model names churn. Launch on a cheaper model and the tiers collapse gracefully.
- **standard** — routine building against a clear spec. Builders default here; a spec with `Complexity: hard` in its Coordination block promotes its builder to deep.
- **mechanical** — applying already-decided fixes, recounts, delta re-checks. Work whose quality is guaranteed by the gate re-running afterwards, not by the model doing it. Default it to the **same rung as standard** — one below the session model, not two: small models flail on real edits, and a flailing fixer costs more than it saves. The tier's identity is its discipline, its escalation semantics, and low reasoning effort where that knob exists — not necessarily a different model. Map it lower only for genuinely deterministic chores.

Classification will sometimes be wrong, so it's cheap to be wrong instead of forbidden: a failed or parked agent retries once on the next *distinct* tier up; security always runs deep; the mechanical gate re-runs after mechanical-tier work regardless; and every manifest line and morning report names the tier each agent ran on — the reports teach you the tuning. No `model-tiers` line, or no per-spawn selection in your harness: everything runs on the session model, visibly. Why this shape and not a config file or per-role routing: ADR 0006.

**And thinking? It inherits.** On most harnesses a spawned agent gets the session's reasoning effort, and there is no per-spawn thinking knob (Claude Code's Task tool takes a model, not a thinking budget; `MAX_THINKING_TOKENS` is session-wide) — which is exactly how a mechanical fixer on a frontier model came to burn 64,000 tokens of thinking before its first tool call. So pstack controls thinking where it actually can: the output-discipline block in every pack — draft in the file, not in your head; tool-call early — which bounds thinking by bounding the work unit. Where a harness does expose per-spawn effort, tier it like the models: deep inherits the session's effort, mechanical runs low.

**Verify, don't trust:** neither the Claude Code CLI nor the desktop app shows which model a running subagent is on, and manifest lines are the conductor *self-reporting*. `scripts/agent-models.sh`, run from a project root, reads Claude Code's own transcripts and prints agent -> model for every spawn — the audit that catches a run that claimed mechanical but spawned everything on deep. Claude Code only (other harnesses don't write those transcripts; there the manifest is the pointer); optional diagnostic, never load-bearing.

The document templates in this repo (`PRODUCT.md`, `CLAUDE.md`, `ROADMAP.md`, `specs/_TEMPLATE.md`, `STATE.md`, …) show the artifacts the workflow maintains — you don't copy them in by hand; `/ps-start` writes the docs into your project from your dump, and `/ps-checkpoint` keeps `STATE.md` current. The one file you start with is your own `dump.md`.

## The workflow

**Braindump, then one command:**

Write `dump.md` first — three loose headings (what & why, what done looks like, what's already known), messy on purpose. Dictating it is faster than typing, and everything downstream is capped by what you say — so say a lot, badly.

```
/ps-start    gates the dump, interviews you on the gaps, then writes
             PRODUCT.md, CLAUDE.md (with its Capabilities map),
             ROADMAP.md, and one spec per phase
```

The same command covers all three situations — it detects which one it's in:
- **New project** — specs the whole product from your dump.
- **Existing codebase** — surveys the code *first*, then asks only what the code can't answer (the why, the forward intent); writes or augments the docs, never overwriting.
- **Live pstack project, new ideas** — extends the plan: appends phases, leaves the rest alone.

Details still undecided become `[OPEN: ...]` markers in the specs — deliberately. The build skills raise each one when the phase that needs it starts, so you decide at the last responsible moment, knowing the most. Phases that are genuinely independent get `Depends on:` and `Surface:` lines; anything performance-shaped gets a numeric budget, not an adjective.

**Build — pick your autonomy:**

| Gear | Command | When |
|------|---------|------|
| Hands-on | `/ps-build` | you steer piece by piece; red tests shown before any code |
| Autonomous | `/ps-dormammu [mvp \| N \| N-M] [--parallel] [context]` | a phase, the MVP, or everything — overnight, in dependency waves |

Both gears write the tests themselves from each phase's acceptance criteria — budgets and UI checks included; there is no separate test step. Both loop against the **mechanical gate** (formatter, strict typecheck, scoped tests, benchmarks) before any review attention is spent. `/ps-dormammu` opens with a pre-flight (one batched round of questions while you're still at the keyboard), then conducts unattended: one fresh-context builder per phase, waves from the specs' dependencies, worktrees where `--parallel` and disjoint surfaces allow — per phase: tests red -> build green -> gate -> panel -> commit, on a branch, never merging.

**The panel** (`/ps-review`, also standalone): fresh-context judgment over the diff, weighted by risk. The default is **one combined judge** carrying every bar — correctness, parsimony (the over-engineering hunt), **product** (built vs specced: gaps, invented scope, intent — with browser eyes on UI phases when the capability is there) — in a single read; it **splits into the full panel** (separate judges, correctness per surface, security as its own judge) only when the diff earns it: a security surface, a multi-surface diff, `Review: full` in the spec, or you asking. Findings come back must-fix / worth-considering / skip-it; conflicts are arbitrated — the spec is the objective function, parsimony wins ties — and every report ends with a manifest line saying what ran, with which providers, on which model tier. Degraded is allowed; invisible is not. Fresh context is the non-negotiable; headcount isn't.

Both gears stop at `/ps-close` — verify the criteria against the tests, review what's being shipped (one integrated judge over the final tree when every phase already closed clean; the full panel for anything parked or flagged), record ADRs, checkpoint, merge. **Shipping is always your call.**

**Every session:** `/ps-resume` to load (docs + git + tests -> a briefing and the next action), `/ps-checkpoint` to save the handoff. **Now and then:** `/ps-doctor` when the environment changed or a manifest line surprises you; `/ps-init` when work happened *outside* the skills (manual commits, another agent, a long gap) — it audits every doc against code, git, and the tests, then repairs the drift with your sign-off. Reality wins; the docs get corrected, never the other way around.

**Change the plan:** just say it — "re-open phase 2", "this isn't working", "add a phase for X" — and `/ps-spec` catches it. A pile of new ideas? Dump again and re-run `/ps-start`.

**Feed it forever — even two streams at once:** a live product takes new dumps as files, not folklore: `/ps-start dump-alerts.md` (any name) extends the plan from reality — it reads STATE.md and git, not just the old roadmap — appends phases, and the dump is spent. And if a dormammu run is still mid-flight when the next idea lands, start anyway: the new `/ps-start` moves itself to a sibling worktree off main (one working tree, one run — branches named `ps/<slug>`, discovered from git itself), reads the live run's claimed phases and surfaces from its branch, and shapes the new phases around them — disjoint where possible, parked as blocked-by-that-run where a dependency is real, since a dependency only counts once its phase has *landed on main*. Runs then land one at a time: `/ps-close` reconciles ROADMAP as a union, regenerates STATE.md, and tells you which parked phases just unblocked. Details: ADR 0004.

Full activity map: [PSTACK.md](./PSTACK.md). Worked example, dump to build: [EXAMPLE.md](./EXAMPLE.md).

## The artifacts

- `dump.md` — the braindump inbox: new project, adopted codebase, or new ideas. Scratch — overwrite freely.
- `PRODUCT.md` — the vision (why). `CLAUDE.md` — how you build (conventions + the `## Capabilities` map, auto-loaded each session).
- `ROADMAP.md` — the product map: every phase, its status, a link to its spec.
- `specs/NN-*.md` — one contract per phase: requirements, acceptance-criteria checklist, optional Coordination (depends-on + surface) and Performance budget, hardstop. `[OPEN: ...]` markers welcome until the phase builds.
- `STATE.md` — where you are, next steps (the session handoff).
- `docs/adr/` — architectural decisions, append-only. `tests/` — the executable definition of done. `BACKLOG.md` — parked tangents. `CONTEXT.md` — the glossary (ubiquitous language, `_Avoid_:` synonym bans), grown by the interview as domain vocabulary emerges; craft skills that read CONTEXT.md pick it up for free.

## What's new in 2.x (and migrating from 1.x)

**2.0** — two new skills (`/ps-review`, `/ps-doctor`), and the build gears rebuilt around four ideas: **fresh context per phase** (a thin conductor spawns one builder per phase, so hour six is as sharp as hour one), **waves** (specs may declare `Depends on:` + `Surface:`; independent phases can run in parallel worktrees under `--parallel`, and a failed phase blocks only its descendants), **the mechanical gate** (formatter/typecheck/tests/benchmarks loop before any review), and **the panel** (independent judges replace the single fresh-context review — including a product judge nothing else ships: built vs specced, against PRODUCT.md itself).

**2.1** — continuity: named dumps (`/ps-start dump2.md`), extend-mode planning from reality (STATE.md + git, not just the roadmap), and concurrent runs — one working tree per run, sibling worktrees off main, `ps/<slug>` branches with git itself as the registry, cross-run blocking via one rule (a dependency is satisfied only when its phase has landed on main), and one-at-a-time landing at `/ps-close`. See CHANGELOG.md and ADR 0004.

**2.2** — the craft tier: builders gain model-invoked *moves*, borrowed rather than built (ADR 0005) — a curated mattpocock/skills subset (`prototype`, `diagnosing-bugs`, `resolving-merge-conflicts`, `domain-modeling`, `research`) named in the Capabilities map, invoked by builders when the situation matches. Specs can mark `[OPEN-SPIKE: ...]` questions for the prototype skill to answer instead of the human; captures land in pstack artifacts via a CLAUDE.md standing rule; `CONTEXT.md` becomes the glossary artifact. Process is owned, craft is borrowed: pstack marks the moments, providers supply the moves. Also new: `/ps-init` (audit and realign the docs with the code — see above), and first-class OpenCode support (it reads pstack's existing skill trees natively).

**2.3** — proportionality (ADR 0006), tuned from a real 27-agent, 5h38m field run: the panel defaults to one combined fresh-context judge and splits only when the diff earns it; panel fixes return to the phase's still-warm builder instead of a fresh fix agent; every spawned pack carries an output-discipline block (file-by-file, no restating files in prose or thinking, draft deliverables in the file — born from seven agent deaths at the 64k output cap on a prose-heavy phase, overflow deaths now resume with smaller work units); `model-tiers` routes spawns by task nature (see [Model selection](#model-selection--one-line-three-tiers)); `/ps-close` weighs its review by what already ran. Migration: none — no `model-tiers` line means the session model everywhere, and the split panel is one `Review: full` spec line away.

Migration is a no-op: v1 projects run unchanged. The new spec sections are optional — no Coordination blocks means a linear run, exactly v1's behavior; no providers installed means the panel judges use their inline bars, which are v1's review bars. Add structure and providers only where they pay.

## Status, plainly

This is my personal, opinionated workflow, released as-is. **Fork it, crib it, rip out the Marvel names (`dormammu` is just "build it autonomously"), bend it to your stack.**

- **No maintenance promise.** Issues and PRs may sit unanswered. I change it when *my* projects need it changed.
- **It rides the agents' skill mechanisms, which move.** The `SKILL.md` format is shared across these agents today, but they all still change; it may break when they do. If it does, fork and fix.
- **Providers are other people's software.** ECC, Ponytail, chrome-devtools-mcp, ecc-plan-canvas each have their own maintainers, licenses, and churn. pstack only ever *detects* them — a provider disappearing degrades a judge, never breaks the workflow.
- The defaults and taste are mine. That's the point of an opinionated tool — and the first thing you should override.

Built in the spirit of the Claude Code workflow toolkits that came before it (gstack, oh-my-claudecode, and others). This is my take.

## License

MIT — see [LICENSE](./LICENSE). Do what you like.
