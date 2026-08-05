#!/usr/bin/env sh
# Which model actually ran each spawned subagent? Claude Code's UI doesn't show
# it; the transcripts do. Run from a project root: prints agent -> model, per
# session — the ground truth behind the run reports' manifest lines (those are
# the conductor self-reporting a tier; this is the transcript proving it).
#
# Claude Code only, by necessity: it reads ~/.claude/projects/<slug>/<session>/
# subagents/*.jsonl, which other harnesses (Codex, OpenCode, pi) don't write.
# There it finds nothing and exits 0 — on those harnesses the manifest lines
# are the only pointer. Optional diagnostic, never load-bearing (ADR 0003 spirit).
set -eu

command -v jq >/dev/null 2>&1 || { echo "error: jq required" >&2; exit 1; }

slug=$(pwd | sed 's|[^A-Za-z0-9]|-|g')
root="$HOME/.claude/projects/$slug"

[ -d "$root" ] || { echo "No Claude Code transcripts for this project ($root not found)."; exit 0; }

found=0
for sess in "$root"/*/; do
  [ -d "${sess}subagents" ] || continue
  found=1
  printf '\nsession %s\n' "$(basename "$sess")"
  for f in "${sess}subagents"/agent-*.jsonl; do
    [ -e "$f" ] || continue
    label=$(jq -r 'select(.type=="user") | .message.content | if type=="string" then . else (.[0].text // "") end' "$f" 2>/dev/null | head -1 | cut -c1-72)
    models=$(jq -r 'select(.type=="assistant") | .message.model // empty | select(. != "<synthetic>")' "$f" 2>/dev/null | sort -u | tr '\n' ',' | sed 's/,$//')
    printf '  %-74s %s\n' "${label:-?}" "${models:-?}"
  done
done
[ "$found" -eq 1 ] || echo "No subagent transcripts under $root (no spawns recorded yet)."
