#!/bin/bash

REPO_DIR=~/mtb-journal
LOG_DIR=logs
FILENAME=$1
FILEPATH="$REPO_DIR/$LOG_DIR/$FILENAME"
REMOTE_URL="https://github.com/simonholm/mtb-journal.git"

if [ -z "$FILENAME" ]; then
  echo "Usage: $0 <filename.md>"
  exit 1
fi

if [ ! -d "$REPO_DIR/.git" ]; then
  echo "Cloning repo..."
  git clone "$REMOTE_URL" "$REPO_DIR"
fi

mkdir -p "$REPO_DIR/$LOG_DIR"

if [ ! -f "$FILEPATH" ]; then
  echo "# 📝 $FILENAME" > "$FILEPATH"
  echo "(Created new log file: $FILENAME)"
fi

cd "$REPO_DIR" || exit
git pull --rebase
git add "$LOG_DIR/$FILENAME"
git commit -m "Sync: update $FILENAME" && git push || echo "No changes to commit."
echo "✅ $FILENAME synced."

