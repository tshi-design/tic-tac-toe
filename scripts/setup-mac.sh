#!/usr/bin/env bash
# Run once on your Mac (Homebrew). Creates ~/Projects/personal and clones this repo if needed.
set -euo pipefail

PROJECTS_ROOT="${PROJECTS_ROOT:-$HOME/Projects}"
REPO_DIR="$PROJECTS_ROOT/personal/tic-tac-toe"
REPO_URL="${REPO_URL:-https://github.com/tshi-design/tic-tac-toe.git}"

echo "→ Projects root: $PROJECTS_ROOT"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install from https://brew.sh then re-run."
  exit 1
fi

if ! command -v node >/dev/null 2>&1; then
  echo "→ Installing Node via Homebrew"
  brew install node
fi

if ! command -v git >/dev/null 2>&1; then
  echo "→ Installing Git via Homebrew"
  brew install git
fi

mkdir -p "$PROJECTS_ROOT/personal" "$PROJECTS_ROOT/client" "$PROJECTS_ROOT/experiments" "$PROJECTS_ROOT/archive"

if [ ! -d "$REPO_DIR/.git" ]; then
  echo "→ Cloning $REPO_URL"
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "→ Repo already at $REPO_DIR"
fi

cd "$REPO_DIR"
echo "→ npm install"
npm install
echo "→ Building CSS"
npm run sass:build

cat <<EOF

Done.

Open in Cursor:
  File → Open Folder → $REPO_DIR

Start local preview:
  cd $REPO_DIR
  npm start

Then open http://localhost:8080
EOF
