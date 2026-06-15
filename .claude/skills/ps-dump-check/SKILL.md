---
name: ps-dump-check
description: >
  pstack: assess whether a brain-dump (dump.md) is coherent and complete enough to
  build on. Use when I type /ps-dump-check, when starting a project from a dump (new
  or existing codebase), before /ps-sharpen, or whenever I ask "is this enough", "is
  my dump ready", or paste a rough brief. Scores the dump against explicit readiness
  criteria and refuses to bless a thin one.
---

# Check the brain-dump is ready

The quality of everything downstream is capped by the dump. This is a gate — be honest, do not rubber-stamp. It serves both paths; check the section I filled.

## Steps
1. Read dump.md (or the text I give you) and see which path it's for: "Building something new" (greenfield) or "Adopting an existing codebase" (brownfield).
2. Check it against the readiness criteria for that path, each pass or fail.

   Greenfield:
   - Goal: is the outcome stated, not just a topic?
   - Context: enough background to understand the problem and the constraints?
   - Success: at least a rough notion of what "done" / "working" looks like?
   - Scope: clear what's in, and ideally what's out?
   - Knowns vs unknowns: are the open questions at least gestured at?
   - Specificity: concrete enough to sharpen, not so vague there's nothing to grab?

   Brownfield (orientation):
   - Focus: is it clear where to look in the codebase / which parts matter?
   - Why & direction: the purpose the code can't convey, and where it's headed?
   - Forward intent: a real notion of what I want built or improved next?
   - Ignore list: anything explicitly out of scope to survey (dead code, legacy)?
   - Constraints: stack / deploy / pain points worth knowing before the survey?

3. Give a verdict:
   - READY (most criteria pass): say so, note the few remaining gaps, and tell me to proceed to /ps-sharpen.
   - NOT READY (key criteria fail): do NOT proceed. List exactly what's missing as concrete questions to answer in dump.md, then ask me to flesh it out and re-run. The effort belongs here.
4. Never invent the missing content yourself — that defeats the gate.
