# 0003. Ground library docs in installed source and the open web, not an MCP registry

Status: accepted (2026-07-29)

## Context
The build skills must verify fast-moving library APIs (Polars-class churn) instead of trusting training memory. Three candidate providers for the `docs` capability: an MCP docs registry (e.g. context7) resolved at runtime; the harness's own websearch + webfetch against official docs; the installed package source in the project's environment. Forces: a registry serves docs for *a* version, not necessarily the installed one; a third-party registry is an always-on content channel into the builder's context (supply-chain and prompt-injection surface); MCP tool schemas cost context in every session, including backend sessions that never need them; some target machines are offline. 2.0.0 initially shipped context7 as the default docs provider.

## Decision
The `docs` capability is a ladder, not a service: (1) read the installed source — the package in the venv or `node_modules` is version-exact by construction and cannot be poisoned remotely; (2) official docs via websearch + webfetch, official domains preferred — still untrusted input, which is why it is rung 2; (3) a docs CLI (context7's or another) as optional per-user convenience, never load-bearing. Rejected: any MCP docs registry in the default path.

## Consequences
+ Grounding matches the running version exactly; works offline at rung 1; zero new trust surface and zero tool-schema tax in the default path; nothing to install.
- Occasional lookups are slower than a registry hit (search loops cost tokens); web content remains untrusted input at rung 2; users who liked the registry must install its CLI themselves. Revisit if harnesses ship first-party, version-aware docs retrieval.
