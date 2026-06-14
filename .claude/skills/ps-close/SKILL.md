---
name: ps-close
description: >
  pstack: close out a phase, or a whole product build, and make the ship call. Use
  when I type /ps-close, when work is done and tests pass, or when I say "ship it",
  "wrap up", "let's merge", or "close this out". Composes verify, ADRs, checkpoint,
  review, and the git merge — then marks phases done in ROADMAP.md. The merge is mine.
---

# Close out (phase or product)

Run when a phase — or a whole /ps-dormammu-magic product build — is ready. Orchestrates the existing skills; it's the human-owned ship gate.

## Steps
1. Verify: every acceptance criterion for what's being closed is met in the relevant spec file(s) and the tests pass. For a whole-product close after a dormammu-magic run, check every phase that was built. If anything's outstanding, stop and tell me.
2. If we made any significant or architectural decision that isn't recorded yet, run /ps-adr for each.
3. Run /ps-checkpoint to overwrite STATE.md with the handoff.
4. Review before merge: run /ps-staff-review for code quality (simplicity, readability), and check the diff against the phase specs for completeness — ideally in fresh context or a subagent. Flag any gaps. (After a dormammu run, this is your deep-QA pass over the flagged items.)
5. Guide the git steps: a clean commit history, then merge the branch or open the PR, and tag the version if this is a release. Don't re-narrate the changes in prose — the diff and commit messages are the record.
6. Mark the closed phase(s) done in ROADMAP.md. If phases remain, point me to the next; if the product's done, say so.
