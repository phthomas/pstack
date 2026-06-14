---
name: ps-dump-check
description: >
  pstack: assess whether a brain-dump (dump.md) is coherent and complete enough to
  build on. Use when I type /ps-dump-check, when starting a new project from a dump,
  before /ps-sharpen or /ps-bootstrap, or whenever I ask "is this enough", "is my
  dump ready", or paste a rough brief. Scores the dump against explicit readiness
  criteria and refuses to bless a thin one.
---

# Check the brain-dump is ready

The quality of everything downstream is capped by the dump. This is a gate — be honest, do not rubber-stamp.

## Steps
1. Read dump.md (or the text I give you).
2. Check it against these readiness criteria, each pass or fail:
   - Goal: is the outcome stated, not just a topic?
   - Context: enough background to understand the problem and the constraints?
   - Success: is there at least a rough notion of what "done" or "working" looks like?
   - Scope: is it clear what's in, and ideally what's out?
   - Knowns vs unknowns: are the open questions and uncertainties at least gestured at?
   - Specificity: concrete enough that an interview could sharpen it, rather than so vague there's nothing to grab?
3. Give a verdict:
   - READY (most criteria pass): say so, note the few remaining gaps, and tell me I can proceed to /ps-sharpen or /ps-bootstrap.
   - NOT READY (key criteria fail): do NOT proceed. List exactly what's missing as concrete questions for me to answer in dump.md, then ask me to flesh it out and re-run /ps-dump-check. The effort belongs here.
4. Never invent the missing content yourself — that defeats the gate.
