readonly ROOTS=(
  "${HOME}/.gemini/antigravity/skills"
  "${HOME}/.gemini/jetski/skills"
)
readonly SKILL="$(realpath .)"

for ROOT in "${ROOTS[@]}"; do
  rm -rf "${ROOT}/personal-skills"
  cp -r "${SKILL}" "${ROOT}/personal-skills"
done
