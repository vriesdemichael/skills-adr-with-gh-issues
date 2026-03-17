#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SNIPPET_DIR="$ROOT_DIR/instruction-snippets"

usage() {
  cat <<'EOF'
Usage:
  install-instruction-snippets.sh repo --target-repo <path> [--templates "AGENTS CLAUDE GEMINI COPILOT"] [--force]
  install-instruction-snippets.sh user --profile <claude|gemini> [--force]
  install-instruction-snippets.sh user --template <AGENTS|CLAUDE|GEMINI|COPILOT> --target-file <path> [--force]
EOF
}

copy_file() {
  local source="$1"
  local destination="$2"
  local force="$3"

  mkdir -p "$(dirname "$destination")"
  if [[ -f "$destination" && "$force" != "1" ]]; then
    echo "SKIP  $destination (already exists; use --force to overwrite)"
    return
  fi
  cp "$source" "$destination"
  echo "COPY  $source -> $destination"
}

template_source() {
  case "$1" in
    AGENTS) echo "$SNIPPET_DIR/AGENTS.md" ;;
    CLAUDE) echo "$SNIPPET_DIR/CLAUDE.md" ;;
    GEMINI) echo "$SNIPPET_DIR/GEMINI.md" ;;
    COPILOT) echo "$SNIPPET_DIR/.github/copilot-instructions.md" ;;
    *) echo "Unknown template: $1" >&2; exit 1 ;;
  esac
}

repo_dest() {
  case "$1" in
    AGENTS) echo "AGENTS.md" ;;
    CLAUDE) echo "CLAUDE.md" ;;
    GEMINI) echo "GEMINI.md" ;;
    COPILOT) echo ".github/copilot-instructions.md" ;;
    *) echo "Unknown template: $1" >&2; exit 1 ;;
  esac
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

MODE="$1"
shift

FORCE=0

if [[ "$MODE" == "repo" ]]; then
  TARGET_REPO=""
  TEMPLATES="AGENTS CLAUDE GEMINI COPILOT"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --target-repo)
        TARGET_REPO="$2"
        shift 2
        ;;
      --templates)
        TEMPLATES="$2"
        shift 2
        ;;
      --force)
        FORCE=1
        shift
        ;;
      *)
        echo "Unknown option: $1" >&2
        usage
        exit 1
        ;;
    esac
  done

  if [[ -z "$TARGET_REPO" ]]; then
    echo "--target-repo is required for repo mode" >&2
    exit 1
  fi

  for template in $TEMPLATES; do
    source="$(template_source "$template")"
    destination="$TARGET_REPO/$(repo_dest "$template")"
    copy_file "$source" "$destination" "$FORCE"
  done
  exit 0
fi

if [[ "$MODE" == "user" ]]; then
  PROFILE=""
  TEMPLATE=""
  TARGET_FILE=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --profile)
        PROFILE="$2"
        shift 2
        ;;
      --template)
        TEMPLATE="$2"
        shift 2
        ;;
      --target-file)
        TARGET_FILE="$2"
        shift 2
        ;;
      --force)
        FORCE=1
        shift
        ;;
      *)
        echo "Unknown option: $1" >&2
        usage
        exit 1
        ;;
    esac
  done

  if [[ -n "$PROFILE" ]]; then
    case "$PROFILE" in
      claude)
        TEMPLATE="CLAUDE"
        TARGET_FILE="$HOME/.claude/CLAUDE.md"
        ;;
      gemini)
        TEMPLATE="GEMINI"
        TARGET_FILE="$HOME/.gemini/GEMINI.md"
        ;;
      *)
        echo "Unknown profile: $PROFILE" >&2
        exit 1
        ;;
    esac
  else
    if [[ -z "$TEMPLATE" || -z "$TARGET_FILE" ]]; then
      echo "For user mode without --profile, both --template and --target-file are required" >&2
      exit 1
    fi
  fi

  source="$(template_source "$TEMPLATE")"
  copy_file "$source" "$TARGET_FILE" "$FORCE"
  exit 0
fi

echo "Unknown mode: $MODE" >&2
usage
exit 1
