#!/usr/bin/env sh
# Sync the canonical Claude Code skills into the Codex skills tree.
#
# .claude/skills/ is canonical; .agents/skills/ is generated from it so the
# same ps-* SKILL.md files run on both agents. Re-run after editing any skill.
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src="$root/.claude/skills"
dst="$root/.agents/skills"

[ -d "$src" ] || { echo "error: $src not found" >&2; exit 1; }

mkdir -p "$dst"
rm -rf "$dst"/ps-*
cp -R "$src"/ps-* "$dst"/

count=$(ls -d "$dst"/ps-*/ 2>/dev/null | wc -l | tr -d ' ')
echo "Synced $count skills: .claude/skills -> .agents/skills"
