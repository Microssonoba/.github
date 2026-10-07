#!/usr/bin/env bash
# Creates or updates the org-wide labels in one or more repos.
# Usage: scripts/sync-labels.sh Microssonoba/<repo> [Microssonoba/<repo> ...]
set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 Microssonoba/<repo> [Microssonoba/<repo> ...]" >&2
  exit 1
fi

here="$(cd "$(dirname "$0")" && pwd)"
for repo in "$@"; do
  echo "== $repo"
  grep -Ev '^[[:space:]]*(#|$)' "$here/labels.txt" | while IFS='|' read -r name color desc; do
    gh label create "$name" --repo "$repo" --color "$color" --description "$desc" --force
  done
done
