#!/usr/bin/env bash
set -euo pipefail

# Optional Claude Code PostToolUse hook.
# Purpose: remind agents to keep implementation-planning artifacts in sync
# when code or planning docs change.
#
# This hook is intentionally lightweight. It does not block work, parse the
# whole repo, or try to validate correctness. It prints a short reminder only
# when a touched path looks relevant.

payload="$(cat || true)"

# Best-effort extraction. Claude hook payloads may vary by version/tool.
# Keep this permissive so the hook fails open.
changed_path=""
if command -v jq >/dev/null 2>&1; then
  changed_path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // .tool_input.path // .file_path // .path // empty' 2>/dev/null || true)"
fi

if [ -z "$changed_path" ]; then
  changed_path="$(printf '%s' "$payload" | grep -Eo '([A-Za-z0-9_./-]+\.(md|mdx|ts|tsx|js|jsx|py|rb|go|rs|java|kt|swift|sql|json|yaml|yml))' | head -n 1 || true)"
fi

case "$changed_path" in
  "") exit 0 ;;
  */node_modules/*|*/.git/*|*/dist/*|*/build/*|*/coverage/*) exit 0 ;;
esac

case "$changed_path" in
  *.md|*.mdx|planning/*|plans/*|docs/*|implementation-planner/*|dumplink/*)
    cat <<'MSG'

implementation-planning-ripple:
A planning artifact changed. Check whether related artifacts need updates:
- kickoff doc
- technical design plan
- risks / unknowns register
- task groups / scopes
- dependency foliation layers
- parallelization plan
- build sequence
- initial slices
- tracker
- agent handoff packet

MSG
    ;;
  *.ts|*.tsx|*.js|*.jsx|*.py|*.rb|*.go|*.rs|*.java|*.kt|*.swift|*.sql|*.json|*.yaml|*.yml)
    cat <<'MSG'

implementation-planning-ripple:
Code or config changed. If implementation reality changed the plan, update the planning artifacts:
- affected surfaces / interfaces / state
- technical decisions
- risks / unknowns
- task-group state
- dependency foliation or parallelization
- active slice acceptance checks
- tracker and handoff packet

MSG
    ;;
esac

exit 0
