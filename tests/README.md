# tests/

Tests live here, written in your project's framework — set in CLAUDE.md and chosen by `/ps-test`. The framework is a per-project choice; the pattern below is the same in any language.

Write three kinds, and only these:

1. **Acceptance-criterion tests** — one per checkable criterion in the phase spec file (specs/). The executable form of "done".
2. **Invariant tests** — properties of the critical paths that must always hold (for a data pipeline: schema, row counts, no nulls in key columns, dedup). Assert behaviour and outputs, never internals.
3. **Regression tests** — one for every bug you fix, named after the bug.

Do NOT chase coverage or test trivia. Keep the suite proportional to the phase.

Framework by stack (examples):
- Python -> pytest, `test_*.py`
- Go -> `go test`, `*_test.go`
- Node / TypeScript -> jest or vitest, `*.test.ts`
- Rust -> `cargo test`, `#[test]` and `tests/`

For non-deterministic LLM/agent behaviour, unit-test the deterministic scaffolding (routing, parsing, tool-call shape) and put the probabilistic behaviour in a separate eval harness — don't assert exact model outputs in a unit test.
