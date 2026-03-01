#!/bin/bash

ROOTS=(
  "${HOME}/.gemini/antigravity/skills"
  "${HOME}/.gemini/jetski/skills"
)

# Detect WSL and add Windows-side skill directories
if grep -qEi "(Microsoft|WSL)" /proc/sys/kernel/osrelease 2>/dev/null; then
  # Get Windows USERPROFILE and convert to WSL path
  WIN_USERPROFILE=$(cmd.exe /c "echo %USERPROFILE%" 2>/dev/null | tr -d '\r')
  if [ -n "$WIN_USERPROFILE" ]; then
    WIN_HOME=$(wslpath "$WIN_USERPROFILE")
    ROOTS+=(
      "${WIN_HOME}/.gemini/antigravity/skills"
      "${WIN_HOME}/.gemini/jetski/skills"
    )
  fi
fi
readonly ROOTS

readonly SKILL="$(realpath .)"
for ROOT in "${ROOTS[@]}"; do
  rm -rf "${ROOT}/personal-skills"
  mkdir -p "${ROOT}"
  cp -r "${SKILL}" "${ROOT}/personal-skills"
done
