---
name: ps-sharpen
description: >
  pstack: run a focused interview to turn a brain-dump into a sharpened brief. Use
  when I type /ps-sharpen, after a dump passes /ps-dump-check, or when I say "interview
  me", "let's flesh this out", or "sharpen the dump". Works for both a new project and
  an existing codebase. Produces sharpened_dump.md. Won't interview a dump that's too
  thin.
---

# Sharpen the dump via interview

The cold-start interview — it works on dump.md, for either path: a new product idea, or the orientation for an existing codebase. (For closing open items inside specs/ mid-loop, use /ps-clarify instead.)

## Steps
1. First apply the /ps-dump-check criteria for whichever path the dump is for. If it's NOT ready, stop and tell me to flesh out dump.md first — a thin dump only yields shallow answers.
2. If it's ready, interview me using AskUserQuestion: one question at a time, most consequential first, targeting the gaps — not what I've already answered. For each, offer your recommended default and the tradeoff so I can confirm or redirect.
   - New project: sharpen the goal, success criteria, scope, and the open decisions.
   - Existing codebase: sharpen where to focus, what "better" / "done" means for the forward work, the boundaries of the new phases, and anything ambiguous about the direction.
3. Fold my answers into sharpened_dump.md, which keeps everything from dump.md plus the resolved decisions. Leave my original dump.md untouched as provenance.
4. Stop when the open questions are resolved. Don't over-interview; if I already wrote it, don't re-ask it. Then run /ps-bootstrap (new project) or /ps-adopt (existing codebase).
