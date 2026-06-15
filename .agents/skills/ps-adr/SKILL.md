---
name: ps-adr
description: >
  pstack: create a new Architecture Decision Record. Use this whenever I make or
  record a significant technical or architectural decision — choosing or rejecting a
  library, database, framework, or pattern — or when I type /ps-adr, even if I don't
  say the words "ADR" or "decision record". Also use it when reversing or replacing
  an earlier decision.
---

# Create an Architecture Decision Record

ADRs live in `docs/adr/` as numbered, append-only markdown files. They capture the *why* behind a decision — the reasoning git never stores.

## Steps
1. If the `adr` or `adrs` CLI is installed, prefer it for the file mechanics (`adr new "<title>"`, or `adr new -s <n> "<title>"` to supersede), then fill in the prose. Otherwise do steps 2–5 by hand.
2. Find the next number: list `docs/adr/`, take the highest `NNNN` prefix, add 1, zero-pad to 4 digits.
3. Create `docs/adr/NNNN-<kebab-case-title>.md` from the template below.
4. Fill Context, Decision, and Consequences from our conversation. Pull the reasoning we already discussed; ask me only for anything genuinely missing. Set Status to `accepted` with today's date.
5. If this supersedes an existing ADR, add a `Supersedes [NNNN](...)` line here, and edit the OLD ADR's Status to `Superseded by [NNNN](...)`. Never change anything else in the old file.

Keep each ADR short — a screenful. One decision per file.

## Template

```
# NNNN. <title>

Status: accepted (<date>)

## Context
<The forces at play: what problem, what constraints, what we considered.>

## Decision
<The decision, stated plainly. Note what we rejected and why.>

## Consequences
+ <What gets better.>
- <What gets worse, or what we're now committed to. Note when we'd revisit.>
```
