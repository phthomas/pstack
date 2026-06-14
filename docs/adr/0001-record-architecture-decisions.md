# 1. Record architecture decisions

Status: accepted (<!-- date -->)

## Context
We need to record the architectural decisions made on this project, including the reasoning behind them — the "why" that git history and commit messages do not preserve.

## Decision
We will keep Architecture Decision Records, as described by Michael Nygard. Each significant decision gets one numbered, append-only file in `docs/adr/`. We never edit a past record; when a decision changes, we add a new ADR that supersedes the old one.

## Consequences
+ The reasoning behind decisions survives, which speeds onboarding and prevents re-litigating settled calls.
+ Decisions and their rationale are versioned alongside the code.
- It takes a little discipline to write one per significant decision. Use the `/ps-adr` skill to keep that cheap.
