#!/usr/bin/env bash
set -euo pipefail
# Push current main to https://github.com/yuhemao/helm-stack using GITHUB_TOKEN (Classic ghp_ PAT).
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
if [[ -f "$ROOT/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "$ROOT/.env"
  set +a
fi
TOKEN="${GITHUB_TOKEN:-${GH_TOKEN:-}}"
if [[ -z "$TOKEN" ]]; then
  echo "Missing GITHUB_TOKEN. Put ghp_… in .env (repo scope), or export GITHUB_TOKEN." >&2
  exit 1
fi
if [[ "$TOKEN" == ghu_* ]]; then
  echo "Refusing ghu_ device-flow tokens; they cannot push to the yuhemao org. Use a Classic ghp_ PAT." >&2
  exit 1
fi
PREFIX="${TOKEN:0:4}"
echo "Using token prefix ${PREFIX}... (len=${#TOKEN})"
cd "$(git rev-parse --show-toplevel)"
git remote remove github 2>/dev/null || true
git remote add github "https://x-access-token:${TOKEN}@github.com/yuhemao/helm-stack.git"
GIT_TERMINAL_PROMPT=0 git push -u github main
git remote set-url github https://github.com/yuhemao/helm-stack.git
echo "Pushed to https://github.com/yuhemao/helm-stack"
curl -s "https://api.github.com/repos/yuhemao/helm-stack/commits?per_page=5" | python3 -c 'import sys,json; d=json.load(sys.stdin)
print("commits:")
[print("-", c["sha"][:7], c["commit"]["message"].split("\n")[0]) for c in (d if isinstance(d,list) else [])]'
