# Why pstack exists

I have more ideas than I will ever have time to build. Most of them die not because they're bad, but because the gap between "I have an idea" and "something real exists" is full of friction, and I run out of evenings before I get across it.

When coding agents got good, I assumed that gap would close on its own. It didn't — not at first. I'd describe a project, the agent would enthusiastically build *a* thing, and it would be the wrong thing, or a confident mess, or 80% of something I then had to reverse-engineer. The lesson took a while to sink in: **the agent isn't the bottleneck. The ambiguity is.** An agent told to "just build it" has to guess at a hundred decisions I never made out loud, and it guesses wrong often enough to burn the evening. The same agent, handed a clear contract, is startlingly good.

So the leverage isn't a cleverer prompt. It's structure — machinery that collapses the ambiguity *before* the agent starts typing. pstack is that machinery, built around a few opinions I've come to trust.

**Start from a brain dump, because that's the honest input.** I don't think in clean specs. I think in a messy pile of "wouldn't it be cool if," half-remembered constraints, and stack preferences. Pretending otherwise just adds a step where I procrastinate. So the front door is `dump.md` — say everything, badly — and the first few skills exist only to turn that mess into something an agent can execute: gate it, interview me on the gaps, sort it into specs, close the open questions.

**Put every fact where it changes at its own speed.** The vision barely moves; the current phase moves constantly. If they share a file, you get churn and confusion. So pstack splits things by rate of change — vision, product map, per-phase spec, session state — and each fact lives in exactly one place. The real point is that I should never have to hold the whole plan in my head, because my head will drop it.

**Make "done" something a machine can check.** Acceptance criteria become tests. Decisions become append-only records. If it matters, it's written down somewhere durable — not in my memory, not in a chat I'll lose.

**Treat autonomy as a dial.** Some nights I have an hour and want to aim the agent at one phase. Some nights I have zero time and want to wake up to a whole product. Some afternoons I want to sit in the loop and steer. Same machinery, three gears — plus hardstops, so when the agent hits something it shouldn't decide alone, it stops and tells me instead of barrelling on.

None of this is novel. It's the boring discipline of good software work — specs, tests, decision records — pointed at an agent instead of a team, and shaped around a brain that's long on ideas and short on follow-through.

If yours works like that too — whether that's ADHD or just a full life — this might fit. It's opinionated and it won't suit everyone, and that's fine. I built it for me. I'm putting it out in case the shape is useful to you. Fork it, strip my names off it, make it yours.
