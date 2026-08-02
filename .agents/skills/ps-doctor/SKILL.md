---
name: ps-doctor
description: >
  pstack: check which capability providers this environment actually has —
  reviewers, parsimony, docs lookup, browser, canvas, gate tools, subagents —
  and print the manifest with an install hint per gap. Use when I type
  /ps-doctor, or say "check my setup", "what capabilities do I have", "is
  everything installed", "why did the panel degrade", or right after
  installing pstack or a provider. Offers to write the result into CLAUDE.md's
  Capabilities section so every other skill resolves providers from one place.
---

# Doctor — probe the environment, print the manifest

pstack's core is markdown; everything with a runtime lives in the environment. This skill makes that environment visible: which capabilities resolve, through which provider, and the one-line install hint for each gap. Degraded is allowed — invisible is not.

## Probe (cheap checks, no installs, nothing modified)
- **Correctness / security reviewers** — reviewer agents installed? `ls ~/.claude/agents .claude/agents 2>/dev/null | grep -i review` (ECC's python-/fastapi-/react-/typescript-/code-/security-reviewer, or any others present).
- **Parsimony** — a `ponytail` skill in `~/.claude/skills`, `.claude/skills`, or the plugin list?
- **Docs grounding** — rung 1: a resolvable environment to read (a venv's `site-packages`, `node_modules`)? rung 2: can this harness search and fetch the web (WebSearch/WebFetch on Claude Code)? Optional: a docs CLI if installed. Offline machines run rung 1 only — say so.
- **Browser** — chrome-devtools MCP configured, same places? Playwright in the project's dev dependencies?
- **Canvas** — `command -v ecc-plan-canvas` (needs node on PATH).
- **Craft** — model-invocable moves for builders present? Look for `prototype`, `diagnosing-bugs`, `resolving-merge-conflicts`, `domain-modeling`, `research` in `~/.claude/skills`, `.claude/skills`, or `.agents/skills` (the mattpocock/skills subset, or equivalents). Two of that repo's skills must NOT be present as model-invocable — `tdd` and `code-review` collide with /ps-build's loop and /ps-review's panel; flag them if found without `disable-model-invocation`. Also: does CONTEXT.md (the glossary) exist yet?
- **Gate tools** — per CLAUDE.md's stack: `ruff`, `pyright`, `pytest` — plus `pytest-benchmark` if any spec carries a Performance budget and `hypothesis` if property tests are the convention; or the TS equivalents (formatter, `tsc`, test runner, Playwright).
- **Subagents** — can this harness spawn fresh-context workers (the Task tool on Claude Code)? If not, /ps-dormammu runs its builders as sequential fresh sessions and /ps-review runs its judges one at a time — slower, same contract.

## Report
A short table, one line per capability: capability — provider found (or ✗) — install hint. For example:
- `parsimony ✗ — npx -y skills add DietrichGebert/ponytail`
- `craft ✗ — npx skills add mattpocock/skills (then drop tdd + code-review; README §Providers)`
- `browser ✗ — add chrome-devtools-mcp to .mcp.json (frontend projects only)`
Then the bottom line, plainly: which pstack behaviors currently degrade and to what — panel judges falling back to inline bars, the product judge without browser eyes, budgets with no benchmark runner to enforce them, canvas gates falling back to typed confirm, [OPEN-SPIKE: ...] markers degrading to ordinary [OPEN: ...] questions with no prototype skill to answer them.

## Sync the map
Offer to write or update the `## Capabilities` section in CLAUDE.md to match what was found — capability -> provider -> fallback, one line each. That section is the single place providers are named; every other skill resolves against it, so keep it true rather than aspirational. (No CLAUDE.md yet? /ps-start generates one with this section built in.)
