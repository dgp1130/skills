#!/bin/bash

readonly REPO_ROOT="$(realpath .)"

# Install as a global rule for the unified Gemini config
mkdir -p "${HOME}/.gemini/config/rules"
ln -sf "${REPO_ROOT}/AGENTS.md" "${HOME}/.gemini/config/rules/personal-skills.md"

# Detect WSL and add Windows-side directory
if grep -qEi "(Microsoft|WSL)" /proc/sys/kernel/osrelease 2>/dev/null; then
  # Get Windows USERPROFILE and convert to WSL path
  WIN_USERPROFILE=$(cmd.exe /c "echo %USERPROFILE%" 2>/dev/null | tr -d '\r')
  if [ -n "$WIN_USERPROFILE" ]; then
    WIN_HOME=$(wslpath "$WIN_USERPROFILE")
    mkdir -p "${WIN_HOME}/.gemini/config/rules"
    ln -sf "${REPO_ROOT}/AGENTS.md" "${WIN_HOME}/.gemini/config/rules/personal-skills.md"
  fi
fi
