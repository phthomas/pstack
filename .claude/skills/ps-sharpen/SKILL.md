---
name: ps-sharpen
description: >
  pstack: run a focused interview to turn a brain-dump into a sharpened brief. Use
  when I type /ps-sharpen, after a dump passes /ps-dump-check, or when I say
  "interview me", "let's flesh this out", or "sharpen the dump". Produces
  sharpened_dump.md. Will not interview a dump that's too thin.
---

# Sharpen the dump via interview

This is the cold-start interview — it works on dump.md. (For closing open items inside ROADMAP.md mid-loop, use /ps-clarify instead.)

## Steps
1. First apply the /ps-dump-check criteria. If the dump is NOT ready, stop and tell me to flesh out dump.md first — a thin dump only yields shallow answers.
2. If it's ready, interview me using AskUserQuestion: one question at a time, most consequential first, targeting the gaps and open questions in the dump — not things I've already answered. For each, offer your recommended default and the tradeoff so I can confirm or redirect.
3. Fold my answers into sharpened_dump.md, which keeps everything from dump.md plus the resolved decisions. Leave my original dump.md untouched as provenance.
4. Stop when the open questions are resolved. Don't over-interview; if I already wrote it, don't re-ask it. Then I can run /ps-bootstrap.
