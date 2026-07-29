---
name: ps-review
description: >
  pstack: run the review panel — parallel fresh-context judges over a diff:
  correctness (per surface), parsimony (over-engineering), product (built vs
  specced), security (on trigger surfaces). Use when I type /ps-review, or say
  "run the panel", "review the diff", "product review", "is this
  over-engineered", "does this match the spec" — and whenever /ps-build,
  /ps-dormammu, or /ps-close needs its review pass. Judges the diff, not the
  repo; resolves judges from CLAUDE.md's Capabilities and degrades to inline
  bars when a provider is missing — visibly, never silently.
---

# Review panel — parallel judges, fresh context, on the diff

One pass, several verdicts. Every judge runs in fresh context (a subagent via the Task tool on Claude Code; a fresh session elsewhere) so nobody reviews code they're anchored on — and every judge reads the DIFF plus only its own context, not the whole repo.

## Scope the diff
Default: the current phase's work — uncommitted changes plus the phase's commits on this branch. Or what I point at: a branch against main, a range, one commit. Collect it once and hand every judge the same diff.

## Resolve the judges
Read CLAUDE.md `## Capabilities` for who provides what (probe cheaply as /ps-doctor does if the section is missing or stale). A missing provider downgrades its judge to the inline bar below — never skip a judge silently; the manifest line says what ran.

1. **Correctness — one judge per surface the diff touches.** Provider: the matching reviewer agents if installed (e.g. ECC's python-reviewer / fastapi-reviewer on the backend, react-reviewer / typescript-reviewer on the frontend, code-reviewer otherwise). Inline bar if absent: the code does what its tests claim; errors and edge cases handled at the boundaries; no obvious races, leaks, or injection points; the tests genuinely check the phase's criteria rather than mirroring the implementation.
2. **Parsimony — the over-engineering hunt.** Provider: ponytail-review if installed. Inline bar if absent: simplest thing that works — flag unnecessary abstraction, premature generalization, speculative flexibility, reinvented stdlib, a dependency where a native feature serves; readability in one pass — flag dense one-liners and cleverness that hides intent; deletability — no dead code, redundancy, or needless layers; consistency with CLAUDE.md. The best fix is usually less code.
3. **Product — built vs specced. Always runs; no provider exists for this — it's ours.** Context: PRODUCT.md, the phase's Requirements and Acceptance criteria, the diff — nothing else, so it judges intent, not implementation taste. For UI phases with the browser capability present, load the built pages and look (console clean? specced states reachable? does what renders match what PRODUCT.md is trying to be?) under a hard timeout; otherwise judge from the Playwright artifacts. Its only questions: anything in the spec missing from the build? anything in the build absent from the spec — invented scope gets flagged even when it's good? any criterion satisfied in letter but missed in intent? Style is out of scope — the other judges own it.
4. **Security — only when the diff touches a trigger surface**: auth or sessions, secrets or keys, file upload, money movement, deserialization, or raw external input reaching shell/SQL/eval. Provider: security-reviewer if installed. Inline bar if absent: inputs validated at the boundary, secrets never logged or committed, authorization checked on every new path.

Run the judges in parallel where the harness allows; sequential is fine — fresh context is not optional.

## Verdict and arbitration
Merge the reports:
- Findings as **must-fix / worth-considering / skip-it** — one line each: location, issue, the concrete fix. Confirm what's already clean; don't invent problems.
- Judges will conflict — correctness wants an abstraction, parsimony wants it gone. Arbitrate: **the spec and PRODUCT.md are the objective function; parsimony wins ties.** Unbuilt abstraction is cheap to add later; built abstraction is expensive to remove.
- End with the manifest line, always — degraded is allowed, invisible is not:
  `panel: correctness(python ✓ ecc, fastapi ✓ ecc) · parsimony ✓ ponytail · product ✓ (browser ✗ — no devtools MCP) · security — not triggered`

## When a build skill invoked this
Return the merged report to the caller; the loop is theirs — fix the must-fixes, re-run the mechanical gate, re-review the deltas only, capped at 3 cycles, then park with findings flagged. Hands-on (/ps-build, /ps-close): findings come to me, and fixes are applied only with my OK.
